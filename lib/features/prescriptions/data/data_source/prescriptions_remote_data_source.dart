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
    await _validatePrescriptionForCreate(item);
    await _validateActiveBranch(item.branchId);
    await _validateActivePrescriptionMedications(item);

    final document = await _prescriptions.add({
      ...item.toFirestoreJson(),
      'status': 'pending',
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

    if (newStatus is String) {
      await _updatePrescriptionStatus(id: id, newStatus: newStatus);
      return;
    }

    await _prescriptions.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _updatePrescriptionStatus({
    required String id,
    required String newStatus,
  }) async {
    if (newStatus == 'dispensed') {
      await _dispensePrescription(id);
      return;
    }

    final prescriptionReference = _prescriptions.doc(id);

    await _firestore.runTransaction((transaction) async {
      final prescriptionSnapshot = await transaction.get(prescriptionReference);

      if (!prescriptionSnapshot.exists) {
        throw Exception('prescription_not_found');
      }

      final prescription = PrescriptionModel.fromFirestore(
        prescriptionSnapshot,
      );

      _validateStatusTransition(
        currentStatus: prescription.status,
        nextStatus: newStatus,
      );

      await _validateActiveBranchInTransaction(
        transaction,
        prescription.branchId,
      );
      await _validateActivePrescriptionMedicationsInTransaction(
        transaction,
        prescription,
      );

      transaction.update(prescriptionReference, {
        'status': newStatus,
        'updated_at': FieldValue.serverTimestamp(),
      });
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

      _validateStatusTransition(
        currentStatus: prescription.status,
        nextStatus: 'dispensed',
      );

      if (prescription.items.isEmpty) {
        throw Exception('prescription_has_no_items');
      }

      await _validateActiveBranchInTransaction(
        transaction,
        prescription.branchId,
      );
      await _validateActivePrescriptionMedicationsInTransaction(
        transaction,
        prescription,
      );

      final requestedQuantitiesByMedicationId = <String, int>{};
      final medicationNamesByMedicationId = <String, String>{};

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

        requestedQuantitiesByMedicationId[medicationId] =
            (requestedQuantitiesByMedicationId[medicationId] ?? 0) + quantity;
        medicationNamesByMedicationId[medicationId] = medicationName;
      }

      final inventorySnapshotsByMedicationId =
          <String, DocumentSnapshot<Map<String, dynamic>>>{};

      for (final entry in requestedQuantitiesByMedicationId.entries) {
        final medicationId = entry.key;
        final requestedQuantity = entry.value;
        final medicationName =
            medicationNamesByMedicationId[medicationId] ?? '';

        final inventoryReference = _inventory.doc(
          '${prescription.branchId}_$medicationId',
        );

        final inventorySnapshot = await transaction.get(inventoryReference);

        if (!inventorySnapshot.exists) {
          throw Exception('not_enough_stock_for_medication:$medicationName');
        }

        final inventoryData = inventorySnapshot.data();

        if (inventoryData == null) {
          throw Exception('not_enough_stock_for_medication:$medicationName');
        }

        if (_isExpired(inventoryData['expiry_date'])) {
          throw Exception('expired_stock_for_medication:$medicationName');
        }

        final currentQuantity = _readInt(inventoryData['quantity']);

        if (currentQuantity < requestedQuantity) {
          throw Exception('not_enough_stock_for_medication:$medicationName');
        }

        inventorySnapshotsByMedicationId[medicationId] = inventorySnapshot;
      }

      transaction.update(prescriptionReference, {
        'status': 'dispensed',
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final entry in requestedQuantitiesByMedicationId.entries) {
        final medicationId = entry.key;
        final quantity = entry.value;
        final medicationName =
            medicationNamesByMedicationId[medicationId] ?? '';

        final inventorySnapshot =
            inventorySnapshotsByMedicationId[medicationId]!;
        final inventoryData = inventorySnapshot.data()!;
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity - quantity;

        transaction.update(inventorySnapshot.reference, {
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

  Future<void> _validatePrescriptionForCreate(
    PrescriptionModel prescription,
  ) async {
    if (prescription.patientName.trim().isEmpty) {
      throw Exception('patient_name_required');
    }

    if ((prescription.doctorName ?? '').trim().isEmpty) {
      throw Exception('doctor_name_required');
    }

    if (prescription.branchId.trim().isEmpty) {
      throw Exception('prescription_missing_branch');
    }

    if (prescription.items.isEmpty) {
      throw Exception('prescription_has_no_items');
    }

    for (final item in prescription.items) {
      final medicationId = item.medicationId;
      final quantity = item.quantity ?? 0;

      if (medicationId == null || medicationId.trim().isEmpty) {
        throw Exception('prescription_item_missing_medication_id');
      }

      if (quantity <= 0) {
        throw Exception('prescription_item_invalid_quantity');
      }
    }
  }

  Future<void> _validateActiveBranch(String branchId) async {
    final branchSnapshot = await _branches.doc(branchId).get();

    if (!branchSnapshot.exists) {
      throw Exception('branch_not_found');
    }

    final branchData = branchSnapshot.data();

    if (branchData == null) {
      throw Exception('branch_not_found');
    }

    if (branchData['is_active'] == false) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateActiveBranchInTransaction(
    Transaction transaction,
    String branchId,
  ) async {
    final branchSnapshot = await transaction.get(_branches.doc(branchId));

    if (!branchSnapshot.exists) {
      throw Exception('branch_not_found');
    }

    final branchData = branchSnapshot.data();

    if (branchData == null) {
      throw Exception('branch_not_found');
    }

    if (branchData['is_active'] == false) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateActivePrescriptionMedications(
    PrescriptionModel prescription,
  ) async {
    for (final item in prescription.items) {
      final medicationId = item.medicationId;
      final medicationName = item.medicationName ?? '';

      if (medicationId == null || medicationId.trim().isEmpty) {
        throw Exception('prescription_item_missing_medication_id');
      }

      final medicationSnapshot = await _medications.doc(medicationId).get();

      if (!medicationSnapshot.exists) {
        throw Exception('medication_not_found:$medicationName');
      }

      final medicationData = medicationSnapshot.data();

      if (medicationData == null) {
        throw Exception('medication_not_found:$medicationName');
      }

      if (medicationData['is_active'] == false) {
        throw Exception('inactive_medication:$medicationName');
      }
    }
  }

  Future<void> _validateActivePrescriptionMedicationsInTransaction(
    Transaction transaction,
    PrescriptionModel prescription,
  ) async {
    for (final item in prescription.items) {
      final medicationId = item.medicationId;
      final medicationName = item.medicationName ?? '';

      if (medicationId == null || medicationId.trim().isEmpty) {
        throw Exception('prescription_item_missing_medication_id');
      }

      final medicationSnapshot = await transaction.get(
        _medications.doc(medicationId),
      );

      if (!medicationSnapshot.exists) {
        throw Exception('medication_not_found:$medicationName');
      }

      final medicationData = medicationSnapshot.data();

      if (medicationData == null) {
        throw Exception('medication_not_found:$medicationName');
      }

      if (medicationData['is_active'] == false) {
        throw Exception('inactive_medication:$medicationName');
      }
    }
  }

  void _validateStatusTransition({
    required String currentStatus,
    required String nextStatus,
  }) {
    if (currentStatus == 'dispensed') {
      throw Exception('prescription_already_dispensed');
    }

    if (currentStatus == 'rejected') {
      throw Exception('prescription_already_rejected');
    }

    if (currentStatus == 'expired') {
      throw Exception('prescription_already_expired');
    }

    if (nextStatus == 'verified' && currentStatus == 'pending') {
      return;
    }

    if (nextStatus == 'rejected' &&
        (currentStatus == 'pending' || currentStatus == 'verified')) {
      return;
    }

    if (nextStatus == 'dispensed' && currentStatus == 'verified') {
      return;
    }

    if (nextStatus == 'dispensed' && currentStatus != 'verified') {
      throw Exception('prescription_not_verified');
    }

    throw Exception('invalid_prescription_status_transition');
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
