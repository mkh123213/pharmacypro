import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/inventory_model.dart';

class InventoryRemoteDataSource {
  InventoryRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _inventory => _firestore.collection('inventory');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');
  CollectionReference<Map<String, dynamic>> get _medications => _firestore.collection('medications');

  Future<List<InventoryModel>> getInventory() async {
    final snapshot = await _inventory.orderBy('created_at', descending: true).get();
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
    await _inventory.doc(item.id).update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return InventoryModel.fromFirestore(await _inventory.doc(item.id).get());
  }
}
