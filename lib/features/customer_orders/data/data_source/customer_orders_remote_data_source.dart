import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/customer_order_model.dart';

class CustomerOrdersRemoteDataSource {
  CustomerOrdersRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _orders {
    return _firestore.collection('customer_orders');
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

  Future<void> deleteCustomerOrder(String id) async {
    final reference = _orders.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('customer_order_not_found');
    }

    await reference.delete();
  }

  Future<List<CustomerOrderModel>> getCustomerOrders() async {
    final snapshot = await _orders
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(CustomerOrderModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<CustomerOrderModel> createCustomerOrder(
    CustomerOrderModel item,
  ) async {
    await _validateCustomerOrder(item);

    final orderReference = _orders.doc();

    await _firestore.runTransaction((transaction) async {
      await _validateActiveBranchInTransaction(
        transaction: transaction,
        branchId: item.branchId,
      );

      for (final orderItem in item.items) {
        await _validateActiveMedicationInTransaction(
          transaction: transaction,
          medicationId: orderItem.medicationId,
          medicationName: orderItem.medicationName,
        );

        await _validateAvailableInventoryInTransaction(
          transaction: transaction,
          branchId: item.branchId,
          medicationId: orderItem.medicationId,
          medicationName: orderItem.medicationName,
          requestedQuantity: orderItem.quantity,
        );
      }

      transaction.set(orderReference, {
        ...item.toFirestoreJson(),
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    });

    return CustomerOrderModel.fromFirestore(await orderReference.get());
  }

  Future<void> updateCustomerOrderFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final newStatus = data['status'];

    if (newStatus is String) {
      await _validateStatusTransition(id: id, newStatus: newStatus);
    }

    if (newStatus == 'delivered') {
      await _deliverCustomerOrder(id);
      return;
    }

    await _orders.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _deliverCustomerOrder(String id) async {
    final orderReference = _orders.doc(id);

    await _firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderReference);

      if (!orderSnapshot.exists) {
        throw Exception('customer_order_not_found');
      }

      final order = CustomerOrderModel.fromFirestore(orderSnapshot);

      if (order.status == 'delivered') {
        throw Exception('customer_order_already_delivered');
      }

      if (order.status == 'cancelled') {
        throw Exception('customer_order_already_cancelled');
      }

      if (order.items.isEmpty) {
        throw Exception('customer_order_has_no_items');
      }

      await _validateActiveBranchInTransaction(
        transaction: transaction,
        branchId: order.branchId,
      );

      final inventoryDocumentsByMedicationId =
          <String, DocumentSnapshot<Map<String, dynamic>>>{};

      for (final item in order.items) {
        await _validateActiveMedicationInTransaction(
          transaction: transaction,
          medicationId: item.medicationId,
          medicationName: item.medicationName,
        );

        final inventorySnapshot =
            await _validateAvailableInventoryInTransaction(
              transaction: transaction,
              branchId: order.branchId,
              medicationId: item.medicationId,
              medicationName: item.medicationName,
              requestedQuantity: item.quantity,
            );

        inventoryDocumentsByMedicationId[item.medicationId] = inventorySnapshot;
      }

      transaction.update(orderReference, {
        'status': 'delivered',
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final item in order.items) {
        final inventoryDocument =
            inventoryDocumentsByMedicationId[item.medicationId]!;

        final inventoryData = inventoryDocument.data() ?? <String, dynamic>{};
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity - item.quantity;

        transaction.update(inventoryDocument.reference, {
          'quantity': newQuantity,
          'updated_at': FieldValue.serverTimestamp(),
        });

        final stockMovementReference = _stockMovements.doc();

        transaction.set(stockMovementReference, {
          'medication_id': item.medicationId,
          'medication_name': item.medicationName,
          'branch_id': order.branchId,
          'branch_name': order.branchName,
          'type': 'customer_order_delivered',
          'quantity_change': -item.quantity,
          'quantity_before': currentQuantity,
          'quantity_after': newQuantity,
          'reference_id': order.id,
          'reference_type': 'customer_order',
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> _validateCustomerOrder(CustomerOrderModel order) async {
    if (order.customerName.trim().isEmpty) {
      throw Exception('customer_order_customer_name_required');
    }

    if (order.branchId.trim().isEmpty) {
      throw Exception('customer_order_missing_branch');
    }

    if (order.items.isEmpty) {
      throw Exception('customer_order_has_no_items');
    }

    if (!_validOrderTypes.contains(order.orderType)) {
      throw Exception('customer_order_invalid_type');
    }

    if (!_validPaymentMethods.contains(order.paymentMethod)) {
      throw Exception('customer_order_invalid_payment_method');
    }

    if (order.orderType == 'delivery' &&
        (order.deliveryAddress == null ||
            order.deliveryAddress!.trim().isEmpty)) {
      throw Exception('customer_order_delivery_address_required');
    }

    if (order.totalAmount < 0) {
      throw Exception('customer_order_invalid_total');
    }

    for (final item in order.items) {
      if (item.medicationId.trim().isEmpty) {
        throw Exception('customer_order_item_missing_medication');
      }

      if (item.quantity <= 0) {
        throw Exception('customer_order_item_invalid_quantity');
      }

      if (item.unitPrice < 0) {
        throw Exception('customer_order_item_invalid_unit_price');
      }

      if (item.total < 0) {
        throw Exception('customer_order_item_invalid_total');
      }
    }
  }

  Future<void> _validateStatusTransition({
    required String id,
    required String newStatus,
  }) async {
    final snapshot = await _orders.doc(id).get();

    if (!snapshot.exists) {
      throw Exception('customer_order_not_found');
    }

    final order = CustomerOrderModel.fromFirestore(snapshot);

    if (order.status == 'delivered') {
      throw Exception('customer_order_already_delivered');
    }

    if (order.status == 'cancelled') {
      throw Exception('customer_order_already_cancelled');
    }

    if (newStatus == 'cancelled') {
      return;
    }

    final expectedNextStatus = _nextStatus(order.status);

    if (expectedNextStatus == null || expectedNextStatus != newStatus) {
      throw Exception('invalid_customer_order_status_transition');
    }
  }

  String? _nextStatus(String status) {
    switch (status) {
      case 'pending':
        return 'confirmed';
      case 'confirmed':
        return 'processing';
      case 'processing':
        return 'ready';
      case 'ready':
        return 'out_for_delivery';
      case 'out_for_delivery':
        return 'delivered';
      default:
        return null;
    }
  }

  Future<void> _validateActiveBranchInTransaction({
    required Transaction transaction,
    required String branchId,
  }) async {
    final branchSnapshot = await transaction.get(_branches.doc(branchId));

    if (!branchSnapshot.exists) {
      throw Exception('branch_not_found');
    }

    final branchData = branchSnapshot.data() ?? <String, dynamic>{};

    if (!_readBool(branchData['is_active'], defaultValue: true)) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateActiveMedicationInTransaction({
    required Transaction transaction,
    required String medicationId,
    required String medicationName,
  }) async {
    final medicationSnapshot = await transaction.get(
      _medications.doc(medicationId),
    );

    if (!medicationSnapshot.exists) {
      throw Exception('medication_not_found:$medicationName');
    }

    final medicationData = medicationSnapshot.data() ?? <String, dynamic>{};

    if (!_readBool(medicationData['is_active'], defaultValue: true)) {
      throw Exception('inactive_medication:$medicationName');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
  _validateAvailableInventoryInTransaction({
    required Transaction transaction,
    required String branchId,
    required String medicationId,
    required String medicationName,
    required int requestedQuantity,
  }) async {
    final inventorySnapshot = await transaction.get(
      _inventory.doc(
        _inventoryDocumentId(branchId: branchId, medicationId: medicationId),
      ),
    );

    if (!inventorySnapshot.exists) {
      throw Exception('not_enough_stock_for_medication:$medicationName');
    }

    final inventoryData = inventorySnapshot.data() ?? <String, dynamic>{};

    if (_isExpired(inventoryData['expiry_date'])) {
      throw Exception('expired_stock_for_medication:$medicationName');
    }

    final currentQuantity = _readInt(inventoryData['quantity']);

    if (currentQuantity < requestedQuantity) {
      throw Exception('not_enough_stock_for_medication:$medicationName');
    }

    return inventorySnapshot;
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

const _validOrderTypes = ['pickup', 'delivery'];
const _validPaymentMethods = ['cash', 'card', 'online'];
