import 'report_chart_model.dart';

class ReportsSummaryModel {
  const ReportsSummaryModel({
    required this.expiredItems,
    required this.expiringSoonItems,
    required this.healthyStockItems,
    required this.inventoryHealthSummary,
    required this.totalRevenue,
    required this.totalCost,
    required this.totalProfit,
    required this.profitMarginPercent,
    required this.totalOrders,
    required this.totalSalesCount,
    required this.lowStockItems,
    required this.prescriptionsCount,
    required this.dailyRevenue,
    required this.dailyProfit,
    required this.revenueByBranch,
    required this.paymentMethods,
    required this.orderStatusBreakdown,
    required this.totalStockIn,
    required this.totalStockOut,
    required this.manualAdjustmentsCount,
    required this.stockMovementByType,
    required this.mostMovedMedications,
    required this.topProfitableMedications,
    required this.topSellingMedications,
  });

  final double totalRevenue;
  final double totalCost;
  final double totalProfit;
  final double profitMarginPercent;
  final int totalOrders;
  final int totalSalesCount;
  final int lowStockItems;
  final int prescriptionsCount;

  final List<ReportChartModel> dailyRevenue;
  final List<ReportChartModel> dailyProfit;
  final List<ReportChartModel> revenueByBranch;
  final List<ReportChartModel> paymentMethods;
  final List<ReportChartModel> orderStatusBreakdown;

  final int totalStockIn;
  final int totalStockOut;
  final int manualAdjustmentsCount;

  final List<ReportChartModel> stockMovementByType;
  final List<ReportChartModel> mostMovedMedications;
  final List<ReportChartModel> topProfitableMedications;
  final List<ReportChartModel> topSellingMedications;
  final int expiredItems;
  final int expiringSoonItems;
  final int healthyStockItems;
  final List<ReportChartModel> inventoryHealthSummary;
}
