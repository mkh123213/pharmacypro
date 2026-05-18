import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer_order_item_model.dart';

part 'customer_order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerOrderModel {
  const CustomerOrderModel({
    required this.id,
    required this.customerName,
    required this.branchId,
    required this.totalAmount,
    this.orderNumber,
    this.customerEmail,
    this.customerPhone,
    this.deliveryAddress,
    this.branchName,
    this.orderType = 'pickup',
    this.items = const [],
    this.status = 'pending',
    this.paymentMethod = 'cash',
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  @JsonKey(name: 'order_number')
  final String? orderNumber;

  @JsonKey(name: 'customer_name')
  final String customerName;

  @JsonKey(name: 'customer_email')
  final String? customerEmail;

  @JsonKey(name: 'customer_phone')
  final String? customerPhone;

  @JsonKey(name: 'delivery_address')
  final String? deliveryAddress;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  @JsonKey(name: 'order_type')
  final String orderType;

  final List<CustomerOrderItemModel> items;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  final String status;

  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  final String? notes;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) => _$CustomerOrderModelFromJson(json);

  factory CustomerOrderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return CustomerOrderModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$CustomerOrderModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }

  CustomerOrderModel copyWith({
    String? status,
  }) {
    return CustomerOrderModel(
      id: id,
      orderNumber: orderNumber,
      customerName: customerName,
      customerEmail: customerEmail,
      customerPhone: customerPhone,
      deliveryAddress: deliveryAddress,
      branchId: branchId,
      branchName: branchName,
      orderType: orderType,
      items: items,
      totalAmount: totalAmount,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}

DateTime? dateTimeFromJson(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

Object? dateTimeToJson(DateTime? value) {
  if (value == null) return null;
  return Timestamp.fromDate(value);
}
