import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sale_item_model.dart';

part 'sale_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleModel {
  const SaleModel({
    required this.id,
    required this.branchId,
    required this.totalAmount,
    this.saleNumber,
    this.branchName,
    this.customerName,
    this.customerPhone,
    this.prescriptionId,
    this.items = const [],
    this.subtotal = 0,
    this.discount = 0,
    this.paymentMethod = 'cash',
    this.status = 'completed',
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  @JsonKey(name: 'sale_number')
  final String? saleNumber;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  @JsonKey(name: 'customer_name')
  final String? customerName;

  @JsonKey(name: 'customer_phone')
  final String? customerPhone;

  @JsonKey(name: 'prescription_id')
  final String? prescriptionId;

  final List<SaleItemModel> items;
  final double subtotal;
  final double discount;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  final String status;
  final String? notes;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory SaleModel.fromJson(Map<String, dynamic> json) => _$SaleModelFromJson(json);

  factory SaleModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return SaleModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$SaleModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
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
