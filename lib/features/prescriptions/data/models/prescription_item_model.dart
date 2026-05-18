import 'package:json_annotation/json_annotation.dart';

part 'prescription_item_model.g.dart';

@JsonSerializable()
class PrescriptionItemModel {
  const PrescriptionItemModel({
    this.medicationName,
    this.dosage,
    this.quantity,
    this.instructions,
  });

  @JsonKey(name: 'medication_name')
  final String? medicationName;

  final String? dosage;
  final int? quantity;
  final String? instructions;

  factory PrescriptionItemModel.fromJson(Map<String, dynamic> json) => _$PrescriptionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionItemModelToJson(this);
}
