// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionItemModel _$PrescriptionItemModelFromJson(
  Map<String, dynamic> json,
) => PrescriptionItemModel(
  medicationId: json['medication_id'] as String?,
  medicationName: json['medication_name'] as String?,
  dosage: json['dosage'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  instructions: json['instructions'] as String?,
);

Map<String, dynamic> _$PrescriptionItemModelToJson(
  PrescriptionItemModel instance,
) => <String, dynamic>{
  'medication_id': instance.medicationId,
  'medication_name': instance.medicationName,
  'dosage': instance.dosage,
  'quantity': instance.quantity,
  'instructions': instance.instructions,
};
