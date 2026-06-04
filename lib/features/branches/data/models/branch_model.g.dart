// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  city: json['city'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  managerName: json['manager_name'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  openingHours: json['opening_hours'] as String?,
  createdAt: dateTimeFromJson(json['created_at']),
  updatedAt: dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'phone': instance.phone,
      'email': instance.email,
      'manager_name': instance.managerName,
      'is_active': instance.isActive,
      'opening_hours': instance.openingHours,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
