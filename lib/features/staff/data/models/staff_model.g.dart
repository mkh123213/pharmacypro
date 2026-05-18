// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) => StaffModel(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  branchId: json['branch_id'] as String,
  phone: json['phone'] as String?,
  branchName: json['branch_name'] as String?,
  licenseNumber: json['license_number'] as String?,
  hireDate: json['hire_date'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  avatarUrl: json['avatar_url'] as String?,
  createdAt: dateTimeFromJson(json['created_at']),
  updatedAt: dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$StaffModelToJson(StaffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'license_number': instance.licenseNumber,
      'hire_date': instance.hireDate,
      'is_active': instance.isActive,
      'avatar_url': instance.avatarUrl,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
