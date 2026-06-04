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
    final snapshot = await _branches.limit(100).get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.limit(1000).get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<SaleModel> createSale(SaleModel item) async {
    await _validateSale(item);

    final saleReference = _sales.doc();

    await _firestore.runTransaction((transaction) async {
      final branchReference = _branches.doc(item.branchId);
      final branchSnapshot = await transaction.get(branchReference);

      if (!branchSnapshot.exists) {
        throw Exception('branch_not_found');
      }

      final branchData = branchSnapshot.data() ?? <String, dynamic>{};

      if (!_readBool(branchData['is_active'], defaultValue: true)) {
        throw Exception('inactive_branch');
      }

      final inventoryDocumentsByMedicationId =
          <String, DocumentSnapshot<Map<String, dynamic>>>{};

      for (final saleItem in item.items) {
        final medicationReference = _medications.doc(saleItem.medicationId);
        final medicationSnapshot = await transaction.get(medicationReference);

        if (!medicationSnapshot.exists) {
          throw Exception('medication_not_found:${saleItem.medicationName}');
        }

        final medicationData = medicationSnapshot.data() ?? <String, dynamic>{};

        if (!_readBool(medicationData['is_active'], defaultValue: true)) {
          throw Exception('inactive_medication:${saleItem.medicationName}');
        }

        final inventoryReference = _inventory.doc(
          _inventoryDocumentId(
            branchId: item.branchId,
            medicationId: saleItem.medicationId,
          ),
        );

        final inventorySnapshot = await transaction.get(inventoryReference);

        if (!inventorySnapshot.exists) {
          throw Exception(
            'not_enough_stock_for_medication:${saleItem.medicationName}',
          );
        }

        final inventoryData = inventorySnapshot.data() ?? <String, dynamic>{};

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
            inventorySnapshot;
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

  Future<void> deleteSale(String id) async {
    final reference = _sales.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('sale_not_found');
    }

    await reference.delete();
  }

  Future<void> _validateSale(SaleModel sale) async {
    if (sale.branchId.trim().isEmpty) {
      throw Exception('sale_missing_branch');
    }

    if (sale.items.isEmpty) {
      throw Exception('sale_has_no_items');
    }

    if (!_validPaymentMethods.contains(sale.paymentMethod)) {
      throw Exception('sale_invalid_payment_method');
    }

    if (sale.subtotal < 0) {
      throw Exception('sale_invalid_subtotal');
    }

    if (sale.discount < 0) {
      throw Exception('sale_invalid_discount');
    }

    if (sale.discount > sale.subtotal) {
      throw Exception('sale_discount_greater_than_subtotal');
    }

    if (sale.totalAmount < 0) {
      throw Exception('sale_invalid_total');
    }

    for (final item in sale.items) {
      if (item.medicationId.trim().isEmpty) {
        throw Exception('sale_item_missing_medication');
      }

      if (item.quantity <= 0) {
        throw Exception('sale_item_invalid_quantity');
      }

      if (item.unitPrice < 0) {
        throw Exception('sale_item_invalid_unit_price');
      }

      if (item.total < 0) {
        throw Exception('sale_item_invalid_total');
      }
    }
  }

  String _inventoryDocumentId({
    required String branchId,
    required String medicationId,
  }) {
    return '${branchId}_$medicationId';
  }

  int _readInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;

    return 0;
  }

  bool _readBool(Object? value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase().trim() == 'true';
    if (value is num) return value != 0;

    return defaultValue;
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

const _validPaymentMethods = ['cash', 'card', 'insurance', 'online'];
