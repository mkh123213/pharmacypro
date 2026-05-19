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
    final document = await _orders.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return CustomerOrderModel.fromFirestore(await document.get());
  }

  Future<void> updateCustomerOrderFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final newStatus = data['status'];

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

      if (order.items.isEmpty) {
        throw Exception('customer_order_has_no_items');
      }

      final inventoryDocumentsByMedicationId =
          <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

      for (final item in order.items) {
        final inventoryQuery = await _inventory
            .where('branch_id', isEqualTo: order.branchId)
            .where('medication_id', isEqualTo: item.medicationId)
            .limit(1)
            .get();

        if (inventoryQuery.docs.isEmpty) {
          throw Exception(
            'not_enough_stock_for_medication:${item.medicationName}',
          );
        }

        final inventoryDocument = inventoryQuery.docs.first;
        final inventoryData = inventoryDocument.data();

        final currentQuantity = _readInt(inventoryData['quantity']);

        if (currentQuantity < item.quantity) {
          throw Exception(
            'not_enough_stock_for_medication:${item.medicationName}',
          );
        }

        inventoryDocumentsByMedicationId[item.medicationId] = inventoryDocument;
      }

      transaction.update(orderReference, {
        'status': 'delivered',
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final item in order.items) {
        final inventoryDocument =
            inventoryDocumentsByMedicationId[item.medicationId]!;

        final inventoryData = inventoryDocument.data();
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

  int _readInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;

    return 0;
  }
}
