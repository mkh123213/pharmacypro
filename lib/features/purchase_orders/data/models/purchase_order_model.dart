import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'purchase_order_item_model.dart';

part 'purchase_order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PurchaseOrderModel {
  const PurchaseOrderModel({
    required this.id,
    required this.supplierId,
    required this.branchId,
    this.orderNumber,
    this.supplierName,
    this.branchName,
    this.status = 'draft',
    this.orderDate,
    this.expectedDelivery,
    this.totalAmount = 0,
    this.items = const [],
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  @JsonKey(name: 'order_number')
  final String? orderNumber;

  @JsonKey(name: 'supplier_id')
  final String supplierId;

  @JsonKey(name: 'supplier_name')
  final String? supplierName;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  final String status;

  @JsonKey(name: 'order_date')
  final String? orderDate;

  @JsonKey(name: 'expected_delivery')
  final String? expectedDelivery;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  final List<PurchaseOrderItemModel> items;
  final String? notes;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderModelFromJson(json);

  factory PurchaseOrderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return PurchaseOrderModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$PurchaseOrderModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }

  PurchaseOrderModel copyWith({
    String? status,
  }) {
    return PurchaseOrderModel(
      id: id,
      orderNumber: orderNumber,
      supplierId: supplierId,
      supplierName: supplierName,
      branchId: branchId,
      branchName: branchName,
      status: status ?? this.status,
      orderDate: orderDate,
      expectedDelivery: expectedDelivery,
      totalAmount: totalAmount,
      items: items,
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
