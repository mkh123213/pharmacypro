import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staff_model.g.dart';

@JsonSerializable()
class StaffModel {
  const StaffModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.branchId,
    this.phone,
    this.branchName,
    this.licenseNumber,
    this.hireDate,
    this.isActive = true,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String? phone;
  final String role;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  @JsonKey(name: 'license_number')
  final String? licenseNumber;

  @JsonKey(name: 'hire_date')
  final String? hireDate;

  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory StaffModel.fromJson(Map<String, dynamic> json) => _$StaffModelFromJson(json);

  factory StaffModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return StaffModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$StaffModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }
}

DateTime? dateTimeFromJson(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

Object? dateTimeToJson(DateTime? value) {
  if (value == null) return null;
  return Timestamp.fromDate(value);
}
