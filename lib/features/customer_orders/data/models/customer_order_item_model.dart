import 'package:json_annotation/json_annotation.dart';

part 'customer_order_item_model.g.dart';

@JsonSerializable()
class CustomerOrderItemModel {
  const CustomerOrderItemModel({
    required this.medicationId,
    required this.medicationName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  @JsonKey(name: 'medication_id')
  final String medicationId;

  @JsonKey(name: 'medication_name')
  final String medicationName;

  final int quantity;

  @JsonKey(name: 'unit_price')
  final double unitPrice;

  final double total;

  factory CustomerOrderItemModel.fromJson(Map<String, dynamic> json) => _$CustomerOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerOrderItemModelToJson(this);

  CustomerOrderItemModel copyWith({
    String? medicationId,
    String? medicationName,
    int? quantity,
    double? unitPrice,
    double? total,
  }) {
    return CustomerOrderItemModel(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }
}
