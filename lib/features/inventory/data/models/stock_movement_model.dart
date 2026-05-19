import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_movement_model.g.dart';

@JsonSerializable()
class StockMovementModel {
  const StockMovementModel({
    required this.id,
    required this.medicationId,
    required this.branchId,
    required this.type,
    required this.quantityChange,
    required this.quantityBefore,
    required this.quantityAfter,
    this.medicationName,
    this.branchName,
    this.reason,
    this.referenceId,
    this.referenceType,
    this.createdAt,
  });

  final String id;

  @JsonKey(name: 'medication_id')
  final String medicationId;

  @JsonKey(name: 'medication_name')
  final String? medicationName;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  final String type;

  final String? reason;

  @JsonKey(name: 'quantity_change')
  final int quantityChange;

  @JsonKey(name: 'quantity_before')
  final int quantityBefore;

  @JsonKey(name: 'quantity_after')
  final int quantityAfter;

  @JsonKey(name: 'reference_id')
  final String? referenceId;

  @JsonKey(name: 'reference_type')
  final String? referenceType;

  @JsonKey(
    name: 'created_at',
    fromJson: dateTimeFromJson,
    toJson: dateTimeToJson,
  )
  final DateTime? createdAt;

  factory StockMovementModel.fromJson(Map<String, dynamic> json) {
    return _$StockMovementModelFromJson(json);
  }

  factory StockMovementModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? <String, dynamic>{};

    return StockMovementModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$StockMovementModelToJson(this);

  bool get isIncrease => quantityChange > 0;

  bool get isDecrease => quantityChange < 0;
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
