// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseOrderModel _$PurchaseOrderModelFromJson(Map<String, dynamic> json) =>
    PurchaseOrderModel(
      id: json['id'] as String,
      supplierId: json['supplier_id'] as String,
      branchId: json['branch_id'] as String,
      orderNumber: json['order_number'] as String?,
      supplierName: json['supplier_name'] as String?,
      branchName: json['branch_name'] as String?,
      status: json['status'] as String? ?? 'draft',
      orderDate: json['order_date'] as String?,
      expectedDelivery: json['expected_delivery'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PurchaseOrderItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      createdAt: dateTimeFromJson(json['created_at']),
      updatedAt: dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$PurchaseOrderModelToJson(PurchaseOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'supplier_id': instance.supplierId,
      'supplier_name': instance.supplierName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'status': instance.status,
      'order_date': instance.orderDate,
      'expected_delivery': instance.expectedDelivery,
      'total_amount': instance.totalAmount,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
