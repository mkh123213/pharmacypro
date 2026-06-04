import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../models/purchase_order_model.dart';

class PurchaseOrdersRemoteDataSource {
  PurchaseOrdersRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _orders {
    return _firestore.collection('purchase_orders');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  CollectionReference<Map<String, dynamic>> get _medications {
    return _firestore.collection('medications');
  }

  CollectionReference<Map<String, dynamic>> get _suppliers {
    return _firestore.collection('suppliers');
  }

  CollectionReference<Map<String, dynamic>> get _inventory {
    return _firestore.collection('inventory');
  }

  CollectionReference<Map<String, dynamic>> get _stockMovements {
    return _firestore.collection('stock_movements');
  }

  Future<void> deletePurchaseOrder(String id) async {
    final reference = _orders.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('purchase_order_not_found');
    }

    await reference.delete();
  }

  Future<List<PurchaseOrderModel>> getPurchaseOrders() async {
    final snapshot = await _orders
        .orderBy('created_at', descending: true)
        .limit(500)
        .get();

    return snapshot.docs.map(PurchaseOrderModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.limit(100).get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.limit(1000).get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<List<SupplierModel>> getSuppliers() async {
    final snapshot = await _suppliers.limit(200).get();

    return snapshot.docs.map(SupplierModel.fromFirestore).toList();
  }

  Future<PurchaseOrderModel> createPurchaseOrder(
    PurchaseOrderModel item,
  ) async {
    await _validatePurchaseOrderItems(item);
    await _validateActiveSupplier(item.supplierId);
    await _validateActiveBranch(item.branchId);
    await _validateActivePurchaseOrderMedications(item);

    final document = await _orders.add({
      ...item.toFirestoreJson(),
      'status': 'draft',
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return PurchaseOrderModel.fromFirestore(await document.get());
  }

  Future<PurchaseOrderModel> updatePurchaseOrder(
    PurchaseOrderModel item,
  ) async {
    final reference = _orders.doc(item.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('purchase_order_not_found');
    }

    final currentOrder = PurchaseOrderModel.fromFirestore(snapshot);

    if (currentOrder.status != 'draft') {
      throw Exception('only_draft_purchase_orders_can_be_edited');
    }

    await _validatePurchaseOrderItems(item);
    await _validateActiveSupplier(item.supplierId);
    await _validateActiveBranch(item.branchId);
    await _validateActivePurchaseOrderMedications(item);

    await reference.update({
      ...item.toFirestoreJson(),
      'status': 'draft',
      'updated_at': FieldValue.serverTimestamp(),
    });

    return PurchaseOrderModel.fromFirestore(await reference.get());
  }

  Future<void> updatePurchaseOrderFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final newStatus = data['status'];

    if (newStatus is String) {
      if (newStatus == 'received') {
        await _receivePurchaseOrder(id);
        return;
      }

      await _updatePurchaseOrderStatus(id: id, newStatus: newStatus);
      return;
    }

    await _orders.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _updatePurchaseOrderStatus({
    required String id,
    required String newStatus,
  }) async {
    final orderReference = _orders.doc(id);

    await _firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderReference);

      if (!orderSnapshot.exists) {
        throw Exception('purchase_order_not_found');
      }

      final order = PurchaseOrderModel.fromFirestore(orderSnapshot);

      _validateStatusTransition(
        currentStatus: order.status,
        newStatus: newStatus,
      );

      await _validateActiveSupplierInTransaction(transaction, order.supplierId);
      await _validateActiveBranchInTransaction(transaction, order.branchId);
      await _validateActivePurchaseOrderMedicationsInTransaction(
        transaction,
        order,
      );

      transaction.update(orderReference, {
        'status': newStatus,
        'updated_at': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> _receivePurchaseOrder(String id) async {
    final orderReference = _orders.doc(id);

    await _firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderReference);

      if (!orderSnapshot.exists) {
        throw Exception('purchase_order_not_found');
      }

      final order = PurchaseOrderModel.fromFirestore(orderSnapshot);

      _validateStatusTransition(
        currentStatus: order.status,
        newStatus: 'received',
      );

      await _validatePurchaseOrderItems(order);
      await _validateActiveSupplierInTransaction(transaction, order.supplierId);
      await _validateActiveBranchInTransaction(transaction, order.branchId);
      await _validateActivePurchaseOrderMedicationsInTransaction(
        transaction,
        order,
      );

      final inventoryDocumentsByMedicationId =
          <String, DocumentSnapshot<Map<String, dynamic>>>{};

      for (final item in order.items) {
        final inventoryReference = _inventory.doc(
          _inventoryDocumentId(
            branchId: order.branchId,
            medicationId: item.medicationId,
          ),
        );

        final inventorySnapshot = await transaction.get(inventoryReference);

        inventoryDocumentsByMedicationId[item.medicationId] = inventorySnapshot;
      }

      transaction.update(orderReference, {
        'status': 'received',
        'received_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final item in order.items) {
        final inventorySnapshot =
            inventoryDocumentsByMedicationId[item.medicationId]!;

        if (!inventorySnapshot.exists) {
          final inventoryReference = _inventory.doc(
            _inventoryDocumentId(
              branchId: order.branchId,
              medicationId: item.medicationId,
            ),
          );

          transaction.set(inventoryReference, {
            'medication_id': item.medicationId,
            'medication_name': item.medicationName,
            'branch_id': order.branchId,
            'branch_name': order.branchName,
            'quantity': item.quantity,
            'min_stock_level': 10,
            'batch_number': null,
            'expiry_date': null,
            'location_in_store': null,
            'created_at': FieldValue.serverTimestamp(),
            'updated_at': FieldValue.serverTimestamp(),
          });

          final stockMovementReference = _stockMovements.doc();

          transaction.set(stockMovementReference, {
            'medication_id': item.medicationId,
            'medication_name': item.medicationName,
            'branch_id': order.branchId,
            'branch_name': order.branchName,
            'type': 'purchase_received',
            'quantity_change': item.quantity,
            'quantity_before': 0,
            'quantity_after': item.quantity,
            'reference_id': order.id,
            'reference_type': 'purchase_order',
            'created_at': FieldValue.serverTimestamp(),
          });

          continue;
        }

        final inventoryData = inventorySnapshot.data() ?? <String, dynamic>{};
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity + item.quantity;

        transaction.update(inventorySnapshot.reference, {
          'quantity': newQuantity,
          'updated_at': FieldValue.serverTimestamp(),
        });

        final stockMovementReference = _stockMovements.doc();

        transaction.set(stockMovementReference, {
          'medication_id': item.medicationId,
          'medication_name': item.medicationName,
          'branch_id': order.branchId,
          'branch_name': order.branchName,
          'type': 'purchase_received',
          'quantity_change': item.quantity,
          'quantity_before': currentQuantity,
          'quantity_after': newQuantity,
          'reference_id': order.id,
          'reference_type': 'purchase_order',
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  void _validateStatusTransition({
    required String currentStatus,
    required String newStatus,
  }) {
    if (currentStatus == 'cancelled') {
      throw Exception('purchase_order_already_cancelled');
    }

    if (currentStatus == 'received' && newStatus != 'received') {
      throw Exception('purchase_order_already_received');
    }

    if (newStatus == 'cancelled') {
      if (currentStatus == 'received') {
        throw Exception('cannot_cancel_received_purchase_order');
      }

      return;
    }

    final expectedNextStatus = _nextStatus(currentStatus);

    if (expectedNextStatus == null || expectedNextStatus != newStatus) {
      throw Exception('invalid_purchase_order_status_transition');
    }
  }

  String? _nextStatus(String status) {
    switch (status) {
      case 'draft':
        return 'sent';
      case 'sent':
        return 'confirmed';
      case 'confirmed':
        return 'received';
      default:
        return null;
    }
  }

  Future<void> _validatePurchaseOrderItems(PurchaseOrderModel order) async {
    if (order.items.isEmpty) {
      throw Exception('purchase_order_has_no_items');
    }

    if (order.totalAmount <= 0) {
      throw Exception('purchase_order_invalid_total');
    }

    double calculatedTotal = 0;

    for (final item in order.items) {
      if (item.medicationId.trim().isEmpty) {
        throw Exception('purchase_order_item_missing_medication');
      }

      if (item.quantity <= 0) {
        throw Exception('purchase_order_item_invalid_quantity');
      }

      if (item.unitCost <= 0) {
        throw Exception('purchase_order_item_invalid_unit_cost');
      }

      final expectedItemTotal = item.quantity * item.unitCost;

      if (item.total <= 0 || (item.total - expectedItemTotal).abs() > 0.01) {
        throw Exception('purchase_order_item_invalid_total');
      }

      calculatedTotal += item.total;
    }

    if ((order.totalAmount - calculatedTotal).abs() > 0.01) {
      throw Exception('purchase_order_invalid_total');
    }
  }

  Future<void> _validateActiveSupplier(String supplierId) async {
    final supplierSnapshot = await _suppliers.doc(supplierId).get();

    if (!supplierSnapshot.exists) {
      throw Exception('supplier_not_found');
    }

    final supplierData = supplierSnapshot.data();

    if (supplierData == null) {
      throw Exception('supplier_not_found');
    }

    if (!_readBool(supplierData['is_active'], defaultValue: true)) {
      throw Exception('inactive_supplier');
    }
  }

  Future<void> _validateActiveSupplierInTransaction(
    Transaction transaction,
    String supplierId,
  ) async {
    final supplierSnapshot = await transaction.get(_suppliers.doc(supplierId));

    if (!supplierSnapshot.exists) {
      throw Exception('supplier_not_found');
    }

    final supplierData = supplierSnapshot.data();

    if (supplierData == null) {
      throw Exception('supplier_not_found');
    }

    if (!_readBool(supplierData['is_active'], defaultValue: true)) {
      throw Exception('inactive_supplier');
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

    if (!_readBool(branchData['is_active'], defaultValue: true)) {
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

    if (!_readBool(branchData['is_active'], defaultValue: true)) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateActivePurchaseOrderMedications(
    PurchaseOrderModel order,
  ) async {
    for (final item in order.items) {
      final medicationSnapshot = await _medications
          .doc(item.medicationId)
          .get();

      if (!medicationSnapshot.exists) {
        throw Exception('medication_not_found:${item.medicationName}');
      }

      final medicationData = medicationSnapshot.data();

      if (medicationData == null) {
        throw Exception('medication_not_found:${item.medicationName}');
      }

      if (!_readBool(medicationData['is_active'], defaultValue: true)) {
        throw Exception('inactive_medication:${item.medicationName}');
      }
    }
  }

  Future<void> _validateActivePurchaseOrderMedicationsInTransaction(
    Transaction transaction,
    PurchaseOrderModel order,
  ) async {
    for (final item in order.items) {
      final medicationSnapshot = await transaction.get(
        _medications.doc(item.medicationId),
      );

      if (!medicationSnapshot.exists) {
        throw Exception('medication_not_found:${item.medicationName}');
      }

      final medicationData = medicationSnapshot.data();

      if (medicationData == null) {
        throw Exception('medication_not_found:${item.medicationName}');
      }

      if (!_readBool(medicationData['is_active'], defaultValue: true)) {
        throw Exception('inactive_medication:${item.medicationName}');
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
}
