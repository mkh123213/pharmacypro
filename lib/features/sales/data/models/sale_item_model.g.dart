// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleItemModel _$SaleItemModelFromJson(Map<String, dynamic> json) =>
    SaleItemModel(
      medicationId: json['medication_id'] as String,
      medicationName: json['medication_name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$SaleItemModelToJson(SaleItemModel instance) =>
    <String, dynamic>{
      'medication_id': instance.medicationId,
      'medication_name': instance.medicationName,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'total': instance.total,
    };
