import 'inventory_model.dart';

class InventoryAlertModel {
  const InventoryAlertModel({
    required this.id,
    required this.type,
    required this.inventoryItem,
    required this.title,
    required this.message,
    required this.priority,
  });

  final String id;
  final String type;
  final InventoryModel inventoryItem;
  final String title;
  final String message;
  final int priority;

  bool get isLowStock => type == 'low_stock';
  bool get isExpiringSoon => type == 'expiring_soon';
  bool get isExpired => type == 'expired';
}
