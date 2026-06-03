import 'package:json_annotation/json_annotation.dart';

part 'sale_item_model.g.dart';

@JsonSerializable()
class SaleItemModel {
  const SaleItemModel({
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

  factory SaleItemModel.fromJson(Map<String, dynamic> json) => _$SaleItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);

  SaleItemModel copyWith({
    String? medicationId,
    String? medicationName,
    int? quantity,
    double? unitPrice,
    double? total,
  }) {
    return SaleItemModel(
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }
}
