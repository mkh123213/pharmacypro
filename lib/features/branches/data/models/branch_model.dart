import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  const BranchModel({
    required this.id,
    required this.name,
    required this.address,
    this.city,
    this.phone,
    this.email,
    this.managerName,
    this.isActive = true,
    this.openingHours,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String address;
  final String? city;
  final String? phone;
  final String? email;

  @JsonKey(name: 'manager_name')
  final String? managerName;

  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  @JsonKey(name: 'opening_hours')
  final String? openingHours;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);

  factory BranchModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return BranchModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }

  BranchModel copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    String? phone,
    String? email,
    String? managerName,
    bool? isActive,
    String? openingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BranchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      managerName: managerName ?? this.managerName,
      isActive: isActive ?? this.isActive,
      openingHours: openingHours ?? this.openingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
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
