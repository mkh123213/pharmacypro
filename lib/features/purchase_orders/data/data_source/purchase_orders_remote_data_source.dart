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

  Future<List<PurchaseOrderModel>> getPurchaseOrders() async {
    final snapshot = await _orders
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(PurchaseOrderModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<List<SupplierModel>> getSuppliers() async {
    final snapshot = await _suppliers.get();

    return snapshot.docs.map(SupplierModel.fromFirestore).toList();
  }

  Future<PurchaseOrderModel> createPurchaseOrder(
    PurchaseOrderModel item,
  ) async {
    final document = await _orders.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return PurchaseOrderModel.fromFirestore(await document.get());
  }

  Future<void> updatePurchaseOrderFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final newStatus = data['status'];

    if (newStatus == 'received') {
      await _receivePurchaseOrder(id);
      return;
    }

    await _orders.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
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

      if (order.status == 'received') {
        throw Exception('purchase_order_already_received');
      }

      if (order.items.isEmpty) {
        throw Exception('purchase_order_has_no_items');
      }

      final inventoryDocumentsByMedicationId =
          <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

      final missingInventoryMedicationIds = <String>{};

      for (final item in order.items) {
        final inventoryQuery = await _inventory
            .where('branch_id', isEqualTo: order.branchId)
            .where('medication_id', isEqualTo: item.medicationId)
            .limit(1)
            .get();

        if (inventoryQuery.docs.isEmpty) {
          missingInventoryMedicationIds.add(item.medicationId);
        } else {
          inventoryDocumentsByMedicationId[item.medicationId] =
              inventoryQuery.docs.first;
        }
      }

      transaction.update(orderReference, {
        'status': 'received',
        'updated_at': FieldValue.serverTimestamp(),
      });

      for (final item in order.items) {
        final existingInventoryDocument =
            inventoryDocumentsByMedicationId[item.medicationId];

        if (existingInventoryDocument == null) {
          final inventoryReference = _inventory.doc();

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

        final inventoryData = existingInventoryDocument.data();
        final currentQuantity = _readInt(inventoryData['quantity']);
        final newQuantity = currentQuantity + item.quantity;

        transaction.update(existingInventoryDocument.reference, {
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

  int _readInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;

    return 0;
  }
}
