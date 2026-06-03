import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier_model.g.dart';

@JsonSerializable()
class SupplierModel {
  const SupplierModel({
    required this.id,
    required this.name,
    this.contactPerson,
    this.phone,
    this.email,
    this.address,
    this.paymentTerms,
    this.isActive = true,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;

  @JsonKey(name: 'contact_person')
  final String? contactPerson;
  final String? phone;
  final String? email;
  final String? address;
  @JsonKey(name: 'payment_terms')
  final String? paymentTerms;
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;
  final String? notes;
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? updatedAt;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => _$SupplierModelFromJson(json);

  factory SupplierModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return SupplierModel.fromJson({...?doc.data(), 'id': doc.id});
  }

  Map<String, dynamic> toJson() => _$SupplierModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()..remove('id')..remove('created_at')..remove('updated_at');
    return json;
  }
}

DateTime? _dateTimeFromJson(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

Object? _dateTimeToJson(DateTime? value) => value == null ? null : Timestamp.fromDate(value);
