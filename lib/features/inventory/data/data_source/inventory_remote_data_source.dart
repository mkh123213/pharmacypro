import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/inventory_model.dart';

class InventoryRemoteDataSource {
  InventoryRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _inventory {
    return _firestore.collection('inventory');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  CollectionReference<Map<String, dynamic>> get _medications {
    return _firestore.collection('medications');
  }

  CollectionReference<Map<String, dynamic>> get _stockMovements {
    return _firestore.collection('stock_movements');
  }

  Future<List<InventoryModel>> getInventory() async {
    final snapshot = await _inventory
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(InventoryModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<InventoryModel> createInventory(InventoryModel item) async {
    final document = await _inventory.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return InventoryModel.fromFirestore(await document.get());
  }

  Future<InventoryModel> updateInventory(InventoryModel item) async {
    final reference = _inventory.doc(item.id);

    await reference.update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return InventoryModel.fromFirestore(await reference.get());
  }

  Future<InventoryModel> adjustInventoryStock({
    required InventoryModel item,
    required int quantityChange,
    required String reason,
  }) async {
    final inventoryReference = _inventory.doc(item.id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(inventoryReference);

      if (!snapshot.exists) {
        throw Exception('inventory_item_not_found');
      }

      final currentItem = InventoryModel.fromFirestore(snapshot);

      final currentQuantity = currentItem.quantity;
      final newQuantity = currentQuantity + quantityChange;

      if (newQuantity < 0) {
        throw Exception('quantity_cannot_go_below_zero');
      }

      transaction.update(inventoryReference, {
        'quantity': newQuantity,
        'updated_at': FieldValue.serverTimestamp(),
      });

      final movementReference = _stockMovements.doc();

      transaction.set(movementReference, {
        'medication_id': currentItem.medicationId,
        'medication_name': currentItem.medicationName,
        'branch_id': currentItem.branchId,
        'branch_name': currentItem.branchName,
        'type': 'manual_adjustment',
        'reason': reason,
        'quantity_change': quantityChange,
        'quantity_before': currentQuantity,
        'quantity_after': newQuantity,
        'reference_id': currentItem.id,
        'reference_type': 'inventory',
        'created_at': FieldValue.serverTimestamp(),
      });
    });

    return InventoryModel.fromFirestore(await inventoryReference.get());
  }
}
