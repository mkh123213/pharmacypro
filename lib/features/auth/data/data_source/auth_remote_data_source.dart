import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/error_logger.dart';
import '../../../staff/data/models/staff_model.dart';
import '../models/auth_user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('login_failed');
    }

    return _fetchUserProfile(user);
  }

  Future<AuthUserModel> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('not_authenticated');
    }

    return _fetchUserProfile(user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<AuthUserModel> _fetchUserProfile(User user) async {
    try {
      final staffSnapshot = await _firestore
          .collection('staff')
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (staffSnapshot.docs.isEmpty) {
        return _createDefaultAdminProfile(user);
      }

      final staff = StaffModel.fromFirestore(staffSnapshot.docs.first);

      if (!staff.isActive) {
        await _firebaseAuth.signOut();
        throw Exception('account_deactivated');
      }

      return AuthUserModel.fromStaff(uid: user.uid, staff: staff);
    } catch (e, stack) {
      ErrorLogger.log('Error fetching user profile', e, stack);
      rethrow;
    }
  }

  Future<AuthUserModel> _createDefaultAdminProfile(User user) async {
    try {
      final branchesSnapshot = await _firestore
          .collection('branches')
          .limit(1)
          .get();

      final branchId = branchesSnapshot.docs.isNotEmpty
          ? branchesSnapshot.docs.first.id
          : '';
      final branchName = branchesSnapshot.docs.isNotEmpty
          ? (branchesSnapshot.docs.first.data()['name'] as String? ?? '')
          : '';

      final staffDoc = _firestore.collection('staff').doc();

      final staffData = {
        'full_name': user.displayName ?? user.email?.split('@').first ?? 'Admin',
        'email': user.email ?? '',
        'role': 'admin',
        'branch_id': branchId,
        'branch_name': branchName,
        'is_active': true,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };

      await staffDoc.set(staffData);

      final staff = StaffModel.fromFirestore(await staffDoc.get());

      return AuthUserModel.fromStaff(uid: user.uid, staff: staff);
    } catch (e, stack) {
      ErrorLogger.log('Error creating default admin profile', e, stack);
      rethrow;
    }
  }
}
