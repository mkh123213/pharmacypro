import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/branch_model.dart';

class BranchesRemoteDataSource {
  BranchesRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection => _firestore.collection('branches');

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _collection.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<BranchModel> createBranch(BranchModel item) async {
    final document = await _collection.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    final snapshot = await document.get();
    return BranchModel.fromFirestore(snapshot);
  }

  Future<BranchModel> updateBranch(BranchModel item) async {
    await _collection.doc(item.id).update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    final snapshot = await _collection.doc(item.id).get();
    return BranchModel.fromFirestore(snapshot);
  }

  Future<void> updateBranchFields(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
