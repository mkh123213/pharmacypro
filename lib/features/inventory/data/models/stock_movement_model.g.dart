// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockMovementModel _$StockMovementModelFromJson(Map<String, dynamic> json) =>
    StockMovementModel(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      branchId: json['branch_id'] as String,
      type: json['type'] as String,
      quantityChange: (json['quantity_change'] as num).toInt(),
      quantityBefore: (json['quantity_before'] as num).toInt(),
      quantityAfter: (json['quantity_after'] as num).toInt(),
      medicationName: json['medication_name'] as String?,
      branchName: json['branch_name'] as String?,
      reason: json['reason'] as String?,
      referenceId: json['reference_id'] as String?,
      referenceType: json['reference_type'] as String?,
      createdAt: dateTimeFromJson(json['created_at']),
    );

Map<String, dynamic> _$StockMovementModelToJson(StockMovementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medication_id': instance.medicationId,
      'medication_name': instance.medicationName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'type': instance.type,
      'reason': instance.reason,
      'quantity_change': instance.quantityChange,
      'quantity_before': instance.quantityBefore,
      'quantity_after': instance.quantityAfter,
      'reference_id': instance.referenceId,
      'reference_type': instance.referenceType,
      'created_at': dateTimeToJson(instance.createdAt),
    };
