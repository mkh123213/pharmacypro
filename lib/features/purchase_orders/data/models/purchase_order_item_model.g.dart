// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseOrderItemModel _$PurchaseOrderItemModelFromJson(
  Map<String, dynamic> json,
) => PurchaseOrderItemModel(
  medicationId: json['medication_id'] as String,
  medicationName: json['medication_name'] as String,
  quantity: (json['quantity'] as num).toInt(),
  unitCost: (json['unit_cost'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
);

Map<String, dynamic> _$PurchaseOrderItemModelToJson(
  PurchaseOrderItemModel instance,
) => <String, dynamic>{
  'medication_id': instance.medicationId,
  'medication_name': instance.medicationName,
  'quantity': instance.quantity,
  'unit_cost': instance.unitCost,
  'total': instance.total,
};
