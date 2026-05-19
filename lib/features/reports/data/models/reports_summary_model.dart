import 'report_chart_model.dart';

class ReportsSummaryModel {
  const ReportsSummaryModel({
    required this.totalRevenue,
    required this.totalOrders,
    required this.lowStockItems,
    required this.prescriptionsCount,
    required this.dailyRevenue,
    required this.revenueByBranch,
    required this.paymentMethods,
    required this.orderStatusBreakdown,
    required this.totalStockIn,
    required this.totalStockOut,
    required this.manualAdjustmentsCount,
    required this.stockMovementByType,
    required this.mostMovedMedications,
  });

  final double totalRevenue;
  final int totalOrders;
  final int lowStockItems;
  final int prescriptionsCount;

  final List<ReportChartModel> dailyRevenue;
  final List<ReportChartModel> revenueByBranch;
  final List<ReportChartModel> paymentMethods;
  final List<ReportChartModel> orderStatusBreakdown;

  final int totalStockIn;
  final int totalStockOut;
  final int manualAdjustmentsCount;

  final List<ReportChartModel> stockMovementByType;
  final List<ReportChartModel> mostMovedMedications;
}
