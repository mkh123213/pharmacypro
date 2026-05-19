import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../inventory/data/models/inventory_model.dart';
import '../../../inventory/data/models/stock_movement_model.dart';
import '../../../prescriptions/data/models/prescription_model.dart';
import '../../../sales/data/models/sale_model.dart';
import '../models/report_chart_model.dart';
import '../models/reports_summary_model.dart';

class ReportsRemoteDataSource {
  ReportsRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<({ReportsSummaryModel summary, List<BranchModel> branches})>
  getReports({String branchId = 'all'}) async {
    final result = await Future.wait([
      _firestore
          .collection('sales')
          .orderBy('created_at', descending: true)
          .limit(500)
          .get(),
      _firestore.collection('inventory').get(),
      _firestore
          .collection('customer_orders')
          .orderBy('created_at', descending: true)
          .limit(200)
          .get(),
      _firestore
          .collection('prescriptions')
          .orderBy('created_at', descending: true)
          .limit(200)
          .get(),
      _firestore.collection('branches').get(),
      _firestore
          .collection('stock_movements')
          .orderBy('created_at', descending: true)
          .limit(500)
          .get(),
    ]);

    final sales = (result[0]).docs.map(SaleModel.fromFirestore).toList();

    final inventory = (result[1]).docs
        .map(InventoryModel.fromFirestore)
        .toList();

    final orders = (result[2]).docs
        .map(CustomerOrderModel.fromFirestore)
        .toList();

    final prescriptions = (result[3]).docs
        .map(PrescriptionModel.fromFirestore)
        .toList();

    final branches = (result[4]).docs.map(BranchModel.fromFirestore).toList();

    final stockMovements = (result[5]).docs
        .map(StockMovementModel.fromFirestore)
        .toList();

    final filteredSales = branchId == 'all'
        ? sales
        : sales.where((sale) => sale.branchId == branchId).toList();

    final filteredOrders = branchId == 'all'
        ? orders
        : orders.where((order) => order.branchId == branchId).toList();

    final filteredPrescriptions = branchId == 'all'
        ? prescriptions
        : prescriptions
              .where((prescription) => prescription.branchId == branchId)
              .toList();

    final filteredInventory = branchId == 'all'
        ? inventory
        : inventory.where((item) => item.branchId == branchId).toList();

    final filteredStockMovements = branchId == 'all'
        ? stockMovements
        : stockMovements
              .where((movement) => movement.branchId == branchId)
              .toList();

    final lowStockItems = filteredInventory.where((item) {
      return item.isLowStock;
    }).length;

    final expiredItems = filteredInventory.where((item) {
      return item.isExpired;
    }).length;

    final expiringSoonItems = filteredInventory.where((item) {
      return item.isExpiringSoon;
    }).length;

    final healthyStockItems = filteredInventory.where((item) {
      return !item.isLowStock && !item.isExpired && !item.isExpiringSoon;
    }).length;

    final inventoryHealthSummary = [
      ReportChartModel(
        label: 'healthy_stock',
        value: healthyStockItems.toDouble(),
      ),
      ReportChartModel(label: 'low_stock', value: lowStockItems.toDouble()),
      ReportChartModel(
        label: 'expiring_soon',
        value: expiringSoonItems.toDouble(),
      ),
      ReportChartModel(label: 'expired', value: expiredItems.toDouble()),
    ].where((item) => item.value > 0).toList();

    final totalRevenue = filteredSales.fold<double>(
      0,
      (sum, sale) => sum + sale.totalAmount,
    );

    final dailyRevenue = List.generate(30, (index) {
      final date = DateTime.now().subtract(Duration(days: 29 - index));

      final key = DateFormat('yyyy-MM-dd').format(date);

      final value = filteredSales
          .where(
            (sale) =>
                sale.createdAt != null &&
                DateFormat('yyyy-MM-dd').format(sale.createdAt!) == key,
          )
          .fold<double>(0, (sum, sale) => sum + sale.totalAmount);

      return ReportChartModel(
        label: DateFormat('MM/dd').format(date),
        value: value,
      );
    });

    final revenueByBranch = branches
        .map(
          (branch) => ReportChartModel(
            label: branch.name,
            value: sales
                .where((sale) => sale.branchId == branch.id)
                .fold<double>(0, (sum, sale) => sum + sale.totalAmount),
          ),
        )
        .where((item) => item.value > 0)
        .toList();

    final paymentMethods = ['cash', 'card', 'insurance', 'online']
        .map(
          (paymentMethod) => ReportChartModel(
            label: paymentMethod,
            value: filteredSales
                .where((sale) => sale.paymentMethod == paymentMethod)
                .length
                .toDouble(),
          ),
        )
        .where((item) => item.value > 0)
        .toList();

    final orderStatusBreakdown =
        [
              'pending',
              'confirmed',
              'processing',
              'ready',
              'delivered',
              'cancelled',
            ]
            .map(
              (status) => ReportChartModel(
                label: status,
                value: filteredOrders
                    .where((order) => order.status == status)
                    .length
                    .toDouble(),
              ),
            )
            .where((item) => item.value > 0)
            .toList();

    final totalStockIn = filteredStockMovements
        .where((movement) => movement.quantityChange > 0)
        .fold<int>(0, (sum, movement) => sum + movement.quantityChange);

    final totalStockOut = filteredStockMovements
        .where((movement) => movement.quantityChange < 0)
        .fold<int>(0, (sum, movement) => sum + movement.quantityChange.abs());

    final manualAdjustmentsCount = filteredStockMovements
        .where((movement) => movement.type == 'manual_adjustment')
        .length;

    final stockMovementByType = _buildStockMovementByType(
      filteredStockMovements,
    );

    final mostMovedMedications = _buildMostMovedMedications(
      filteredStockMovements,
    );

    return (
      summary: ReportsSummaryModel(
        totalRevenue: totalRevenue,
        totalOrders: filteredOrders.length,
        lowStockItems: lowStockItems,
        expiredItems: expiredItems,
        expiringSoonItems: expiringSoonItems,
        healthyStockItems: healthyStockItems,
        inventoryHealthSummary: inventoryHealthSummary,
        prescriptionsCount: filteredPrescriptions.length,
        dailyRevenue: dailyRevenue,
        revenueByBranch: revenueByBranch,
        paymentMethods: paymentMethods,
        orderStatusBreakdown: orderStatusBreakdown,
        totalStockIn: totalStockIn,
        totalStockOut: totalStockOut,
        manualAdjustmentsCount: manualAdjustmentsCount,
        stockMovementByType: stockMovementByType,
        mostMovedMedications: mostMovedMedications,
      ),
      branches: branches,
    );
  }

  List<ReportChartModel> _buildStockMovementByType(
    List<StockMovementModel> movements,
  ) {
    const types = [
      'sale',
      'purchase_received',
      'customer_order_delivered',
      'prescription_dispensed',
      'manual_adjustment',
      'expired_removed',
    ];

    return types
        .map(
          (type) => ReportChartModel(
            label: type,
            value: movements
                .where((movement) => movement.type == type)
                .length
                .toDouble(),
          ),
        )
        .where((item) => item.value > 0)
        .toList();
  }

  List<ReportChartModel> _buildMostMovedMedications(
    List<StockMovementModel> movements,
  ) {
    final totals = <String, double>{};

    for (final movement in movements) {
      final name = movement.medicationName?.trim();

      if (name == null || name.isEmpty) continue;

      totals[name] = (totals[name] ?? 0) + movement.quantityChange.abs();
    }

    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries
        .take(8)
        .map((entry) => ReportChartModel(label: entry.key, value: entry.value))
        .toList();
  }
}
