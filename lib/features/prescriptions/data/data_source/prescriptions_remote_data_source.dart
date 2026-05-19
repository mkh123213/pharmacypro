import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/prescription_model.dart';

class PrescriptionsRemoteDataSource {
  PrescriptionsRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _prescriptions {
    return _firestore.collection('prescriptions');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  CollectionReference<Map<String, dynamic>> get _medications {
    return _firestore.collection('medications');
  }

  CollectionReference<Map<String, dynamic>> get _inventory {
    return _firestore.collection('inventory');
  }

  CollectionReference<Map<String, dynamic>> get _stockMovements {
    return _firestore.collection('stock_movements');
  }

  Future<List<PrescriptionModel>> getPrescriptions() async {
    final snapshot = await _prescriptions
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(PrescriptionModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<PrescriptionModel> createPrescription(PrescriptionModel item) async {
    final document = await _prescriptions.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return PrescriptionModel.fromFirestore(await document.get());
  }

  Future<void> updatePrescriptionFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final newStatus = data['status'];

    if (newStatus == 'dispensed') {
      await _dispensePrescription(id);
      return;
    }

    await _prescriptions.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _dispensePrescription(String id) async {
    final prescriptionReference = _prescriptions.doc(id);

    await _firestore.runTransaction((transaction) async {
      final prescriptionSnapshot = await transaction.get(prescriptionReference);

      if (!prescriptionSnapshot.exists) {
        throw Exception('prescription_not_found');
      }

      final prescription = PrescriptionModel.fromFirestore(
        prescriptionSnapshot,
      );

      if (prescription.status == 'dispensed') {
        throw Exception('prescription_already_dispensed');
      }

      if (prescription.items.isEmpty) {
        throw Exception('prescription_has_no_items');
      }

      final inventoryDocumentsByMedicationId =
          <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

      for (final item in prescription.items) {
        final medicationId = item.medicationId;
        final medicationName = item.medicationName ?? '';
        final quantity = item.quantity ?? 0;

        if (medicationId == null || medicationId.trim().isEmpty) {
          throw Exception('prescription_item_missing_medication_id');
        }

        if (quantity <= 0) {
          throw Exception('prescription_item_invalid_quantity');
        }

        final inventoryQuery = await _inventory
            .where('branch_id', isEqualTo: prescription.branchId)
            .where('medication_id', isEqualTo: medicationId)
            .limit(1)
            .get();

        if (inventoryQuery.docs.isEmpty) {
          throw Exception('not_enough_stock_for_medication:$medicationName');
        }

        final inventoryDocument = inventoryQuery.docs.first;
        final inventoryData = inventoryDocument.data();

        if (_isExpired(inventoryData['expiry_date'])) {
          throw Exception('expired_stock_for_medication:$medicationName');
        }

        final currentQuantity = _readInt(inventoryData['quantity']);

        if (currentQuantity < quantity) {
          throw Exception('not_enough_stock_for_medication:$medicationName');
        }

        inventoryDocumentsByMedicationId[medicationId] = inventoryDocument;
      }

      transaction.update(prescriptionReference, {
        'status': 'dispensed',
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final item in prescription.items) {
        final medicationId = item.medicationId!;
        final medicationName = item.medicationName ?? '';
        final quantity = item.quantity ?? 0;

        final inventoryDocument =
            inventoryDocumentsByMedicationId[medicationId]!;

        final inventoryData = inventoryDocument.data();
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity - quantity;

        transaction.update(inventoryDocument.reference, {
          'quantity': newQuantity,
          'updated_at': FieldValue.serverTimestamp(),
        });

        final stockMovementReference = _stockMovements.doc();

        transaction.set(stockMovementReference, {
          'medication_id': medicationId,
          'medication_name': medicationName,
          'branch_id': prescription.branchId,
          'branch_name': prescription.branchName,
          'type': 'prescription_dispensed',
          'quantity_change': -quantity,
          'quantity_before': currentQuantity,
          'quantity_after': newQuantity,
          'reference_id': prescription.id,
          'reference_type': 'prescription',
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  int _readInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;

    return 0;
  }

  bool _isExpired(Object? value) {
    if (value == null) return false;

    final text = value.toString().trim();

    if (text.isEmpty) return false;

    final date = DateTime.tryParse(text);

    if (date == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiryDay = DateTime(date.year, date.month, date.day);

    return expiryDay.isBefore(today);
  }
}
