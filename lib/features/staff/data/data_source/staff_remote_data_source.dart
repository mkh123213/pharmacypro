import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../branches/data/models/branch_model.dart';
import '../models/staff_model.dart';

class StaffRemoteDataSource {
  StaffRemoteDataSource({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })  : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  CollectionReference<Map<String, dynamic>> get _staff {
    return _firestore.collection('staff');
  }

  CollectionReference<Map<String, dynamic>> get _branches {
    return _firestore.collection('branches');
  }

  Future<List<StaffModel>> getStaff() async {
    final snapshot = await _staff.orderBy('created_at', descending: true).limit(200).get();

    return snapshot.docs.map(StaffModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.limit(100).get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<StaffModel> createStaff(StaffModel item, {required String password}) async {
    await _validateStaff(item);
    await _validateActiveBranch(item.branchId);
    await _validateUniqueEmail(email: item.email);

    if (password.trim().length < 6) {
      throw Exception('staff_password_too_short');
    }

    await _createAuthAccount(email: item.email.trim(), password: password);

    final document = await _staff.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return StaffModel.fromFirestore(await document.get());
  }

  Future<void> _createAuthAccount({
    required String email,
    required String password,
  }) async {
    FirebaseApp? secondaryApp;
    try {
      secondaryApp = await Firebase.initializeApp(
        name: 'staffAccountCreator',
        options: Firebase.app().options,
      );

      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);
      await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await secondaryAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('staff_auth_email_already_in_use');
      }
      if (e.code == 'weak-password') {
        throw Exception('staff_password_too_short');
      }
      throw Exception('staff_auth_account_creation_failed');
    } finally {
      if (secondaryApp != null) {
        await secondaryApp.delete();
      }
    }
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

  Future<void> deleteStaff(String id) async {
    final reference = _staff.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('staff_not_found');
    }

    await reference.delete();
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
