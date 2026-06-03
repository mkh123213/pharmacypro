import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../models/shift_model.dart';

class ShiftsRemoteDataSource {
  ShiftsRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _shifts {
    return _firestore.collection('shifts');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  CollectionReference<Map<String, dynamic>> get _staff {
    return _firestore.collection('staff');
  }

  Future<List<ShiftModel>> getShifts() async {
    final snapshot = await _shifts.orderBy('date').limit(500).get();

    return snapshot.docs.map(ShiftModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.limit(100).get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<StaffModel>> getStaff() async {
    final snapshot = await _staff.limit(200).get();

    return snapshot.docs.map(StaffModel.fromFirestore).toList();
  }

  Future<ShiftModel> createShift(ShiftModel item) async {
    await _validateShift(item);
    await _validateActiveStaff(item.staffId);
    await _validateActiveBranch(item.branchId);

    final document = await _shifts.add({
      ...item.toFirestoreJson(),
      'status': 'scheduled',
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return ShiftModel.fromFirestore(await document.get());
  }

  Future<void> updateShiftFields(String id, Map<String, dynamic> data) async {
    final nextStatus = data['status'];

    if (nextStatus is String) {
      await _updateShiftStatus(id: id, nextStatus: nextStatus);
      return;
    }

    await _shifts.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _updateShiftStatus({
    required String id,
    required String nextStatus,
  }) async {
    final shiftReference = _shifts.doc(id);

    await _firestore.runTransaction((transaction) async {
      final shiftSnapshot = await transaction.get(shiftReference);

      if (!shiftSnapshot.exists) {
        throw Exception('shift_not_found');
      }

      final currentShift = ShiftModel.fromFirestore(shiftSnapshot);

      _validateStatusTransition(
        currentStatus: currentShift.status,
        nextStatus: nextStatus,
      );

      await _validateActiveStaffInTransaction(
        transaction,
        currentShift.staffId,
      );
      await _validateActiveBranchInTransaction(
        transaction,
        currentShift.branchId,
      );

      transaction.update(shiftReference, {
        'status': nextStatus,
        'updated_at': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> _validateActiveStaff(String staffId) async {
    if (staffId.trim().isEmpty) {
      throw Exception('shift_missing_staff');
    }

    final snapshot = await _staff.doc(staffId).get();

    if (!snapshot.exists) {
      throw Exception('staff_not_found');
    }

    final data = snapshot.data();

    if (data == null) {
      throw Exception('staff_not_found');
    }

    if (!_readBool(data['is_active'], defaultValue: true)) {
      throw Exception('inactive_staff');
    }
  }

  Future<void> _validateActiveStaffInTransaction(
    Transaction transaction,
    String staffId,
  ) async {
    if (staffId.trim().isEmpty) {
      throw Exception('shift_missing_staff');
    }

    final snapshot = await transaction.get(_staff.doc(staffId));

    if (!snapshot.exists) {
      throw Exception('staff_not_found');
    }

    final data = snapshot.data();

    if (data == null) {
      throw Exception('staff_not_found');
    }

    if (!_readBool(data['is_active'], defaultValue: true)) {
      throw Exception('inactive_staff');
    }
  }

  Future<void> _validateActiveBranch(String branchId) async {
    if (branchId.trim().isEmpty) {
      throw Exception('shift_missing_branch');
    }

    final snapshot = await _branches.doc(branchId).get();

    if (!snapshot.exists) {
      throw Exception('branch_not_found');
    }

    final data = snapshot.data();

    if (data == null) {
      throw Exception('branch_not_found');
    }

    if (!_readBool(data['is_active'], defaultValue: true)) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateActiveBranchInTransaction(
    Transaction transaction,
    String branchId,
  ) async {
    if (branchId.trim().isEmpty) {
      throw Exception('shift_missing_branch');
    }

    final snapshot = await transaction.get(_branches.doc(branchId));

    if (!snapshot.exists) {
      throw Exception('branch_not_found');
    }

    final data = snapshot.data();

    if (data == null) {
      throw Exception('branch_not_found');
    }

    if (!_readBool(data['is_active'], defaultValue: true)) {
      throw Exception('inactive_branch');
    }
  }

  Future<void> _validateShift(ShiftModel shift) async {
    if (shift.staffId.trim().isEmpty) {
      throw Exception('shift_missing_staff');
    }

    if (shift.branchId.trim().isEmpty) {
      throw Exception('shift_missing_branch');
    }

    if (shift.date.trim().isEmpty ||
        DateTime.tryParse(shift.date.trim()) == null) {
      throw Exception('shift_invalid_date');
    }

    final startMinutes = _minutesFromTime(shift.startTime);
    final endMinutes = _minutesFromTime(shift.endTime);

    if (startMinutes == null || endMinutes == null) {
      throw Exception('shift_invalid_time');
    }

    if (endMinutes <= startMinutes) {
      throw Exception('shift_end_time_must_be_after_start_time');
    }
  }

  void _validateStatusTransition({
    required String currentStatus,
    required String nextStatus,
  }) {
    if (currentStatus == 'completed') {
      throw Exception('shift_already_completed');
    }

    if (currentStatus == 'cancelled') {
      throw Exception('shift_already_cancelled');
    }

    if (nextStatus == 'cancelled') {
      if (currentStatus == 'completed') {
        throw Exception('cannot_cancel_completed_shift');
      }

      return;
    }

    final expectedNext = _nextStatus(currentStatus);

    if (expectedNext == null || expectedNext != nextStatus) {
      throw Exception('invalid_shift_status_transition');
    }
  }

  String? _nextStatus(String status) {
    switch (status) {
      case 'scheduled':
        return 'in_progress';
      case 'in_progress':
        return 'completed';
      default:
        return null;
    }
  }

  int? _minutesFromTime(String value) {
    final parts = value.trim().split(':');

    if (parts.length < 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23) return null;
    if (minute < 0 || minute > 59) return null;

    return hour * 60 + minute;
  }

  bool _readBool(Object? value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase().trim() == 'true';
    if (value is num) return value != 0;

    return defaultValue;
  }
}
