// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrderModel _$CustomerOrderModelFromJson(Map<String, dynamic> json) =>
    CustomerOrderModel(
      id: json['id'] as String,
      customerName: json['customer_name'] as String,
      branchId: json['branch_id'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      orderNumber: json['order_number'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerPhone: json['customer_phone'] as String?,
      deliveryAddress: json['delivery_address'] as String?,
      branchName: json['branch_name'] as String?,
      orderType: json['order_type'] as String? ?? 'pickup',
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    CustomerOrderItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      status: json['status'] as String? ?? 'pending',
      paymentMethod: json['payment_method'] as String? ?? 'cash',
      notes: json['notes'] as String?,
      createdAt: dateTimeFromJson(json['created_at']),
      updatedAt: dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$CustomerOrderModelToJson(CustomerOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'customer_name': instance.customerName,
      'customer_email': instance.customerEmail,
      'customer_phone': instance.customerPhone,
      'delivery_address': instance.deliveryAddress,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'order_type': instance.orderType,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'notes': instance.notes,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
