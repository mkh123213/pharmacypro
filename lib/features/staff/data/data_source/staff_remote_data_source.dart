import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../models/staff_model.dart';

class StaffRemoteDataSource {
  StaffRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _staff => _firestore.collection('staff');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');

  Future<List<StaffModel>> getStaff() async {
    final snapshot = await _staff.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(StaffModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();
    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<StaffModel> createStaff(StaffModel item) async {
    final document = await _staff.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return StaffModel.fromFirestore(await document.get());
  }

  Future<StaffModel> updateStaff(StaffModel item) async {
    await _staff.doc(item.id).update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return StaffModel.fromFirestore(await _staff.doc(item.id).get());
  }
}
