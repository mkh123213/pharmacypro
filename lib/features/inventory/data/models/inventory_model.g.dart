// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      id: json['id'] as String,
      medicationId: json['medication_id'] as String,
      branchId: json['branch_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      medicationName: json['medication_name'] as String?,
      branchName: json['branch_name'] as String?,
      minStockLevel: (json['min_stock_level'] as num?)?.toInt() ?? 10,
      batchNumber: json['batch_number'] as String?,
      expiryDate: json['expiry_date'] as String?,
      locationInStore: json['location_in_store'] as String?,
      createdAt: dateTimeFromJson(json['created_at']),
      updatedAt: dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medication_id': instance.medicationId,
      'medication_name': instance.medicationName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'quantity': instance.quantity,
      'min_stock_level': instance.minStockLevel,
      'batch_number': instance.batchNumber,
      'expiry_date': instance.expiryDate,
      'location_in_store': instance.locationInStore,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
