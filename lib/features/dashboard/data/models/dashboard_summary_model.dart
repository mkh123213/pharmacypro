import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../inventory/data/models/inventory_model.dart';
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
  });

  final List<SaleModel> sales;
  final List<InventoryModel> inventory;
  final List<PrescriptionModel> prescriptions;
  final List<StaffModel> staff;
  final List<CustomerOrderModel> orders;
  final List<DashboardChartModel> last7Days;

  double get totalRevenue => sales.fold(0, (sum, sale) => sum + sale.totalAmount);
  List<InventoryModel> get lowStockItems => inventory.where((item) => item.isLowStock).toList();
  int get pendingPrescriptions => prescriptions.where((item) => item.status == 'pending').length;
  int get activeStaff => staff.where((item) => item.isActive).length;
  int get pendingOrders => orders.where((item) => item.status == 'pending').length;
}
