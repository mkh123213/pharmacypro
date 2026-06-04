// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) => SaleModel(
  id: json['id'] as String,
  branchId: json['branch_id'] as String,
  totalAmount: (json['total_amount'] as num).toDouble(),
  saleNumber: json['sale_number'] as String?,
  branchName: json['branch_name'] as String?,
  customerName: json['customer_name'] as String?,
  customerPhone: json['customer_phone'] as String?,
  prescriptionId: json['prescription_id'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SaleItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
  discount: (json['discount'] as num?)?.toDouble() ?? 0,
  paymentMethod: json['payment_method'] as String? ?? 'cash',
  status: json['status'] as String? ?? 'completed',
  notes: json['notes'] as String?,
  createdAt: dateTimeFromJson(json['created_at']),
  updatedAt: dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$SaleModelToJson(SaleModel instance) => <String, dynamic>{
  'id': instance.id,
  'sale_number': instance.saleNumber,
  'branch_id': instance.branchId,
  'branch_name': instance.branchName,
  'customer_name': instance.customerName,
  'customer_phone': instance.customerPhone,
  'prescription_id': instance.prescriptionId,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'subtotal': instance.subtotal,
  'discount': instance.discount,
  'total_amount': instance.totalAmount,
  'payment_method': instance.paymentMethod,
  'status': instance.status,
  'notes': instance.notes,
  'created_at': dateTimeToJson(instance.createdAt),
  'updated_at': dateTimeToJson(instance.updatedAt),
};
