import '../../../staff/data/models/staff_model.dart';

class AuthUserModel {
  const AuthUserModel({
    required this.uid,
    required this.email,
    required this.role,
    this.staffId,
    this.fullName,
    this.branchId,
    this.branchName,
  });

  final String uid;
  final String email;
  final String role;
  final String? staffId;
  final String? fullName;
  final String? branchId;
  final String? branchName;

  factory AuthUserModel.fromStaff({
    required String uid,
    required StaffModel staff,
  }) {
    return AuthUserModel(
      uid: uid,
      email: staff.email,
      role: staff.role,
      staffId: staff.id,
      fullName: staff.fullName,
      branchId: staff.branchId,
      branchName: staff.branchName,
    );
  }

  bool get isAdmin => role == 'admin';
  bool get isManager => role == 'manager';
  bool get isPharmacist => role == 'pharmacist';
  bool get isCashier => role == 'cashier';
  bool get isTechnician => role == 'technician';
}
