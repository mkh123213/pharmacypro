import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../models/shift_model.dart';

class ShiftsRemoteDataSource {
  ShiftsRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _shifts => _firestore.collection('shifts');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');
  CollectionReference<Map<String, dynamic>> get _staff => _firestore.collection('staff');

  Future<List<ShiftModel>> getShifts() async {
    final snapshot = await _shifts.orderBy('date').get();
    return snapshot.docs.map(ShiftModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async => (await _branches.get()).docs.map(BranchModel.fromFirestore).toList();
  Future<List<StaffModel>> getStaff() async => (await _staff.get()).docs.map(StaffModel.fromFirestore).toList();

  Future<ShiftModel> createShift(ShiftModel item) async {
    final document = await _shifts.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return ShiftModel.fromFirestore(await document.get());
  }

  Future<void> updateShiftFields(String id, Map<String, dynamic> data) async {
    await _shifts.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
