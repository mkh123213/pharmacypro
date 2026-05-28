import 'package:json_annotation/json_annotation.dart';

part 'purchase_order_item_model.g.dart';

@JsonSerializable()
class PurchaseOrderItemModel {
  const PurchaseOrderItemModel({
    required this.medicationId,
    required this.medicationName,
    required this.quantity,
    required this.unitCost,
    required this.total,
  });

  @JsonKey(name: 'medication_id')
  final String medicationId;

  @JsonKey(name: 'medication_name')
  final String medicationName;

  final int quantity;

  @JsonKey(name: 'unit_cost')
  final double unitCost;

  final double total;

  factory PurchaseOrderItemModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseOrderItemModelToJson(this);
}
