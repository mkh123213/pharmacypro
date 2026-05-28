// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationModel _$MedicationModelFromJson(Map<String, dynamic> json) =>
    MedicationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      genericName: json['generic_name'] as String?,
      category: json['category'] as String?,
      dosageForm: json['dosage_form'] as String?,
      strength: json['strength'] as String?,
      manufacturer: json['manufacturer'] as String?,
      barcode: json['barcode'] as String?,
      requiresPrescription: json['requires_prescription'] as bool? ?? false,
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: dateTimeFromJson(json['created_at']),
      updatedAt: dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$MedicationModelToJson(MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'generic_name': instance.genericName,
      'category': instance.category,
      'dosage_form': instance.dosageForm,
      'strength': instance.strength,
      'manufacturer': instance.manufacturer,
      'barcode': instance.barcode,
      'requires_prescription': instance.requiresPrescription,
      'price': instance.price,
      'cost_price': instance.costPrice,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
