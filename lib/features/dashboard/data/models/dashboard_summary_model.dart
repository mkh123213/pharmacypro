import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../inventory/data/models/inventory_model.dart';
import '../../../inventory/data/models/stock_movement_model.dart';
import '../../../prescriptions/data/models/prescription_model.dart';
import '../../../sales/data/models/sale_model.dart';
import '../../../staff/data/models/staff_model.dart';
import 'dashboard_chart_model.dart';

class DashboardSummaryModel {
  const DashboardSummaryModel({
    required this.sales,
    required this.inventory,
    required this.prescriptions,
    required this.staff,
    required this.orders,
    required this.last7Days,
    required this.stockMovements,
  });

  final List<SaleModel> sales;
  final List<InventoryModel> inventory;
  final List<PrescriptionModel> prescriptions;
  final List<StaffModel> staff;
  final List<CustomerOrderModel> orders;
  final List<DashboardChartModel> last7Days;
  final List<StockMovementModel> stockMovements;

  double get totalRevenue {
    return sales.fold(0, (sum, sale) => sum + sale.totalAmount);
  }

  List<InventoryModel> get lowStockItems {
    return inventory.where((item) => item.isLowStock).toList();
  }

  int get pendingPrescriptions {
    return prescriptions.where((item) => item.status == 'pending').length;
  }

  int get activeStaff {
    return staff.where((item) => item.isActive).length;
  }

  int get pendingOrders {
    return orders.where((item) => item.status == 'pending').length;
  }

  List<StockMovementModel> get todayStockMovements {
    final now = DateTime.now();

    return stockMovements.where((movement) {
      final createdAt = movement.createdAt;
      if (createdAt == null) return false;

      return createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day;
    }).toList();
  }

  int get stockInToday {
    return todayStockMovements
        .where((movement) => movement.quantityChange > 0)
        .fold<int>(0, (sum, movement) => sum + movement.quantityChange);
  }

  int get stockOutToday {
    return todayStockMovements
        .where((movement) => movement.quantityChange < 0)
        .fold<int>(0, (sum, movement) => sum + movement.quantityChange.abs());
  }

  int get manualAdjustmentsToday {
    return todayStockMovements
        .where((movement) => movement.type == 'manual_adjustment')
        .length;
  }

  List<StockMovementModel> get recentStockMovements {
    return stockMovements.take(5).toList();
  }
}
