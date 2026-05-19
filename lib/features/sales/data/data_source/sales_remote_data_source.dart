import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/sale_model.dart';

class SalesRemoteDataSource {
  SalesRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _sales {
    return _firestore.collection('sales');
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

  Future<List<SaleModel>> getSales() async {
    final snapshot = await _sales
        .orderBy('created_at', descending: true)
        .limit(100)
        .get();

    return snapshot.docs.map(SaleModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<SaleModel> createSale(SaleModel item) async {
    final saleReference = _sales.doc();

    await _firestore.runTransaction((transaction) async {
      final inventoryDocumentsByMedicationId =
          <String, DocumentSnapshot<Map<String, dynamic>>>{};

      for (final saleItem in item.items) {
        final inventoryQuery = await _inventory
            .where('branch_id', isEqualTo: item.branchId)
            .where('medication_id', isEqualTo: saleItem.medicationId)
            .limit(1)
            .get();

        if (inventoryQuery.docs.isEmpty) {
          throw Exception(
            'not_enough_stock_for_medication:${saleItem.medicationName}',
          );
        }

        final inventoryDocument = inventoryQuery.docs.first;
        final inventoryData = inventoryDocument.data();

        if (_isExpired(inventoryData['expiry_date'])) {
          throw Exception(
            'expired_stock_for_medication:${saleItem.medicationName}',
          );
        }

        final currentQuantity = _readInt(inventoryData['quantity']);

        if (currentQuantity < saleItem.quantity) {
          throw Exception(
            'not_enough_stock_for_medication:${saleItem.medicationName}',
          );
        }

        inventoryDocumentsByMedicationId[saleItem.medicationId] =
            inventoryDocument;
      }

      transaction.set(saleReference, {
        ...item.toFirestoreJson(),
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final saleItem in item.items) {
        final inventoryDocument =
            inventoryDocumentsByMedicationId[saleItem.medicationId]!;

        final inventoryData = inventoryDocument.data() ?? <String, dynamic>{};
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity - saleItem.quantity;

        transaction.update(inventoryDocument.reference, {
          'quantity': newQuantity,
          'updated_at': FieldValue.serverTimestamp(),
        });

        final stockMovementReference = _stockMovements.doc();

        transaction.set(stockMovementReference, {
          'medication_id': saleItem.medicationId,
          'medication_name': saleItem.medicationName,
          'branch_id': item.branchId,
          'branch_name': item.branchName,
          'type': 'sale',
          'quantity_change': -saleItem.quantity,
          'quantity_before': currentQuantity,
          'quantity_after': newQuantity,
          'reference_id': saleReference.id,
          'reference_type': 'sale',
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    });

    return SaleModel.fromFirestore(await saleReference.get());
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
