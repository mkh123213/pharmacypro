import 'package:flutter/material.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../inventory/presentation/refactor/inventory_alert_filter_values.dart';
import '../../data/models/dashboard_summary_model.dart';

class DashboardSummaryCardData {
  const DashboardSummaryCardData({
    required this.titleKey,
    required this.value,
    required this.subtitleKey,
    required this.icon,
    this.route,
  });

  final String titleKey;
  final String value;
  final String subtitleKey;
  final IconData icon;
  final String? route;
}

List<DashboardSummaryCardData> buildDashboardSummaryCards(
  DashboardSummaryModel summary,
) {
  return [
    DashboardSummaryCardData(
      titleKey: LangKeys.lowStockAlerts,
      value: '${summary.lowStockItems.length}',
      subtitleKey: LangKeys.needRestocking,
      icon: Icons.warning_amber,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.lowStock,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.expiringSoon,
      value: '${summary.expiringSoonItems}',
      subtitleKey: LangKeys.itemsExpiringSoon,
      icon: Icons.schedule,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.expiringSoon,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.expiredItems,
      value: '${summary.expiredItems}',
      subtitleKey: LangKeys.removeFromStock,
      icon: Icons.error_outline,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.expired,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.totalRevenue,
      value: '\$${summary.totalRevenue.toStringAsFixed(2)}',
      subtitleKey: LangKeys.allTime,
      icon: Icons.attach_money,
      route: AppRoutes.reports,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.pendingPrescriptions,
      value: '${summary.pendingPrescriptions}',
      subtitleKey: LangKeys.awaitingReview,
      icon: Icons.receipt_long,
      route: AppRoutes.prescriptions,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.activeStaff,
      value: '${summary.activeStaff}',
      subtitleKey: LangKeys.acrossAllBranches,
      icon: Icons.people,
      route: AppRoutes.staff,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.stockInToday,
      value: '${summary.stockInToday}',
      subtitleKey: LangKeys.itemsAddedToday,
      icon: Icons.trending_up,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.stockOutToday,
      value: '${summary.stockOutToday}',
      subtitleKey: LangKeys.itemsRemovedToday,
      icon: Icons.trending_down,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.manualAdjustmentsToday,
      value: '${summary.manualAdjustmentsToday}',
      subtitleKey: LangKeys.adjustmentsToday,
      icon: Icons.tune,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.pendingOrders,
      value: '${summary.pendingOrders}',
      subtitleKey: LangKeys.awaitingProcessing,
      icon: Icons.shopping_bag_outlined,
      route: AppRoutes.orders,
    ),
  ];
}
