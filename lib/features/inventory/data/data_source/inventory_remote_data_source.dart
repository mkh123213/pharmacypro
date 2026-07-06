import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/inventory_alert_model.dart';
import '../models/stock_movement_model.dart';

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

  Future<void> deleteInventoryItem(String id) async {
    final reference = _inventory.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('inventory_item_not_found');
    }

    await reference.delete();
  }

  static const int pageSize = 20;

  Future<(List<InventoryModel>, DocumentSnapshot?)> getInventory({
    DocumentSnapshot? startAfter,
    int limit = pageSize,
  }) async {
    Query<Map<String, dynamic>> query = _inventory
        .orderBy('created_at', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();

    final inventory = snapshot.docs.map(InventoryModel.fromFirestore).toList();
    final lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (inventory, lastDocument);
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.limit(100).get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.limit(1000).get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<InventoryModel> createInventory(InventoryModel item) async {
    await _validateInventoryItem(item);
    await _validateActiveBranchAndMedication(
      branchId: item.branchId,
      medicationId: item.medicationId,
    );

    final inventoryId = _inventoryDocumentId(
      branchId: item.branchId,
      medicationId: item.medicationId,
    );

    final reference = _inventory.doc(inventoryId);
    final snapshot = await reference.get();

    if (snapshot.exists) {
      throw Exception('duplicate_inventory_item');
    }

    await reference.set({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return InventoryModel.fromFirestore(await reference.get());
  }

  Future<InventoryModel> updateInventory(InventoryModel item) async {
    final reference = _inventory.doc(item.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('inventory_item_not_found');
    }

    await _validateInventoryItem(item);
    await _validateActiveBranchAndMedication(
      branchId: item.branchId,
      medicationId: item.medicationId,
    );

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
    if (quantityChange == 0) {
      throw Exception('inventory_adjustment_quantity_required');
    }

    if (reason.trim().isEmpty) {
      throw Exception('inventory_adjustment_reason_required');
    }

    final inventoryReference = _inventory.doc(item.id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(inventoryReference);

      if (!snapshot.exists) {
        throw Exception('inventory_item_not_found');
      }

      final currentItem = InventoryModel.fromFirestore(snapshot);

      await _validateActiveBranchAndMedication(
        branchId: currentItem.branchId,
        medicationId: currentItem.medicationId,
      );

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
        'reason': reason.trim(),
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

  Future<InventoryModel> removeExpiredStock({
    required InventoryModel item,
    required String reason,
  }) async {
    if (reason.trim().isEmpty) {
      throw Exception('inventory_adjustment_reason_required');
    }

    final inventoryReference = _inventory.doc(item.id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(inventoryReference);

      if (!snapshot.exists) {
        throw Exception('inventory_item_not_found');
      }

      final currentItem = InventoryModel.fromFirestore(snapshot);

      if (currentItem.quantity <= 0) {
        throw Exception('expired_stock_quantity_already_zero');
      }

      final currentQuantity = currentItem.quantity;
      const newQuantity = 0;
      final quantityChange = -currentQuantity;

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
        'type': 'expired_removed',
        'reason': reason.trim(),
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

  Future<List<StockMovementModel>> getStockMovements() async {
    final snapshot = await _stockMovements
        .orderBy('created_at', descending: true)
        .limit(200)
        .get();

    return snapshot.docs.map(StockMovementModel.fromFirestore).toList();
  }

  Future<List<InventoryAlertModel>> getInventoryAlerts() async {
    // Alerts must consider every inventory item, so page through the
    // whole collection rather than just the first paginated page.
    final inventory = <InventoryModel>[];
    DocumentSnapshot? cursor;

    while (true) {
      final (page, lastDocument) = await getInventory(startAfter: cursor);
      inventory.addAll(page);

      if (page.length < pageSize || lastDocument == null) break;
      cursor = lastDocument;
    }

    final alerts = <InventoryAlertModel>[];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final soonLimit = today.add(const Duration(days: 30));

    for (final item in inventory) {
      if (item.quantity <= item.minStockLevel) {
        alerts.add(
          InventoryAlertModel(
            id: '${item.id}_low_stock',
            type: 'low_stock',
            inventoryItem: item,
            title: item.medicationName ?? '',
            message: '${item.quantity} / ${item.minStockLevel}',
            priority: 2,
          ),
        );
      }

      final expiryText = item.expiryDate;

      if (expiryText == null || expiryText.trim().isEmpty) {
        continue;
      }

      final expiryDate = DateTime.tryParse(expiryText.trim());

      if (expiryDate == null) {
        continue;
      }

      final expiryDay = DateTime(
        expiryDate.year,
        expiryDate.month,
        expiryDate.day,
      );

      if (expiryDay.isBefore(today)) {
        alerts.add(
          InventoryAlertModel(
            id: '${item.id}_expired',
            type: 'expired',
            inventoryItem: item,
            title: item.medicationName ?? '',
            message: expiryText,
            priority: 3,
          ),
        );
      } else if (!expiryDay.isAfter(soonLimit)) {
        alerts.add(
          InventoryAlertModel(
            id: '${item.id}_expiring_soon',
            type: 'expiring_soon',
            inventoryItem: item,
            title: item.medicationName ?? '',
            message: expiryText,
            priority: 1,
          ),
        );
      }
    }

    alerts.sort((a, b) => b.priority.compareTo(a.priority));

    return alerts;
  }

  Future<void> _validateInventoryItem(InventoryModel item) async {
    if (item.medicationId.trim().isEmpty) {
      throw Exception('inventory_missing_medication');
    }

    if (item.branchId.trim().isEmpty) {
      throw Exception('inventory_missing_branch');
    }

    if (item.quantity < 0) {
      throw Exception('inventory_invalid_quantity');
    }

    if (item.minStockLevel < 0) {
      throw Exception('inventory_invalid_min_stock_level');
    }

    final expiryText = item.expiryDate?.trim();

    if (expiryText != null &&
        expiryText.isNotEmpty &&
        DateTime.tryParse(expiryText) == null) {
      throw Exception('inventory_invalid_expiry_date');
    }
  }

  String _inventoryDocumentId({
    required String branchId,
    required String medicationId,
  }) {
    return '${branchId}_$medicationId';
  }

  Future<void> _validateActiveBranchAndMedication({
    required String branchId,
    required String medicationId,
  }) async {
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

    final medicationSnapshot = await _medications.doc(medicationId).get();

    if (!medicationSnapshot.exists) {
      throw Exception('medication_not_found');
    }

    final medicationData = medicationSnapshot.data();

    if (medicationData == null) {
      throw Exception('medication_not_found');
    }

    if (!_readBool(medicationData['is_active'], defaultValue: true)) {
      throw Exception('inactive_medication');
    }
  }

  bool _readBool(Object? value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase().trim() == 'true';
    if (value is num) return value != 0;

    return defaultValue;
  }
}
