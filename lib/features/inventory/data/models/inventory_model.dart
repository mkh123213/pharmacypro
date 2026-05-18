import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_model.g.dart';

@JsonSerializable()
class InventoryModel {
  const InventoryModel({
    required this.id,
    required this.medicationId,
    required this.branchId,
    required this.quantity,
    this.medicationName,
    this.branchName,
    this.minStockLevel = 10,
    this.batchNumber,
    this.expiryDate,
    this.locationInStore,
    this.createdAt,
    this.updatedAt,
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

  final int quantity;

  @JsonKey(name: 'min_stock_level', defaultValue: 10)
  final int minStockLevel;

  @JsonKey(name: 'batch_number')
  final String? batchNumber;

  @JsonKey(name: 'expiry_date')
  final String? expiryDate;

  @JsonKey(name: 'location_in_store')
  final String? locationInStore;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory InventoryModel.fromJson(Map<String, dynamic> json) => _$InventoryModelFromJson(json);

  factory InventoryModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return InventoryModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }

  bool get isLowStock => quantity <= minStockLevel;

  bool get isExpiringSoon {
    if (expiryDate == null || expiryDate!.isEmpty) return false;
    final date = DateTime.tryParse(expiryDate!);
    if (date == null) return false;
    return date.isBefore(DateTime.now().add(const Duration(days: 30)));
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
