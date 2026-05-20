import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../models/staff_model.dart';

class StaffRemoteDataSource {
  StaffRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _staff {
    return _firestore.collection('staff');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  Future<List<StaffModel>> getStaff() async {
    final snapshot = await _staff.orderBy('created_at', descending: true).get();

    return snapshot.docs.map(StaffModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<StaffModel> createStaff(StaffModel item) async {
    await _validateStaff(item);
    await _validateActiveBranch(item.branchId);
    await _validateUniqueEmail(email: item.email);

    final document = await _staff.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return StaffModel.fromFirestore(await document.get());
  }

  Future<StaffModel> updateStaff(StaffModel item) async {
    final reference = _staff.doc(item.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('staff_not_found');
    }

    await _validateStaff(item);
    await _validateActiveBranch(item.branchId);
    await _validateUniqueEmail(email: item.email, excludingId: item.id);

    await reference.update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return StaffModel.fromFirestore(await reference.get());
  }

  Future<void> _validateStaff(StaffModel item) async {
    if (item.fullName.trim().isEmpty) {
      throw Exception('staff_name_required');
    }

    if (item.email.trim().isEmpty) {
      throw Exception('staff_email_required');
    }

    if (!_isValidEmail(item.email.trim())) {
      throw Exception('staff_invalid_email');
    }

    if (item.role.trim().isEmpty) {
      throw Exception('staff_role_required');
    }

    if (!_isValidRole(item.role)) {
      throw Exception('staff_invalid_role');
    }

    if (item.branchId.trim().isEmpty) {
      throw Exception('staff_branch_required');
    }

    final phone = item.phone?.trim();

    if (phone != null && phone.isNotEmpty && phone.length < 7) {
      throw Exception('staff_invalid_phone');
    }

    final hireDate = item.hireDate?.trim();

    if (hireDate != null &&
        hireDate.isNotEmpty &&
        DateTime.tryParse(hireDate) == null) {
      throw Exception('staff_invalid_hire_date');
    }
  }

  Future<void> _validateActiveBranch(String branchId) async {
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

  Future<void> _validateUniqueEmail({
    required String email,
    String? excludingId,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final snapshot = await _staff
        .where('email', isEqualTo: normalizedEmail)
        .get();

    for (final document in snapshot.docs) {
      if (excludingId != null && document.id == excludingId) continue;

      throw Exception('staff_email_already_exists');
    }
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  bool _isValidRole(String value) {
    const roles = ['pharmacist', 'technician', 'cashier', 'manager', 'admin'];

    return roles.contains(value);
  }

  bool _readBool(Object? value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase().trim() == 'true';
    if (value is num) return value != 0;

    return defaultValue;
  }
}
