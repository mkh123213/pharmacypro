import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medication_model.g.dart';

@JsonSerializable()
class MedicationModel {
  const MedicationModel({
    required this.id,
    required this.name,
    required this.price,
    this.genericName,
    this.category,
    this.dosageForm,
    this.strength,
    this.manufacturer,
    this.barcode,
    this.requiresPrescription = false,
    this.costPrice,
    this.description,
    this.imageUrl,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;

  @JsonKey(name: 'generic_name')
  final String? genericName;

  final String? category;

  @JsonKey(name: 'dosage_form')
  final String? dosageForm;

  final String? strength;
  final String? manufacturer;
  final String? barcode;

  @JsonKey(name: 'requires_prescription', defaultValue: false)
  final bool requiresPrescription;

  final double price;

  @JsonKey(name: 'cost_price')
  final double? costPrice;

  final String? description;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory MedicationModel.fromJson(Map<String, dynamic> json) => _$MedicationModelFromJson(json);

  factory MedicationModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return MedicationModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$MedicationModelToJson(this);

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
