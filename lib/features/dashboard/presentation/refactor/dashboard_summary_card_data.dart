import 'package:flutter/material.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';

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
    this.imagePath,
    this.route,
  });

  final String titleKey;
  final String value;
  final String subtitleKey;
  final IconData icon;

  /// Optional illustration shown instead of [icon] when provided.
  final String? imagePath;
  final String? route;
}

List<DashboardSummaryCardData> buildDashboardSummaryCards(
  DashboardSummaryModel summary,
  BuildContext context,
) {
  // final globalKey = context;
  return [
    DashboardSummaryCardData(
      titleKey: LangKeys.lowStockAlerts,
      value: '${summary.lowStockItems.length}',
      subtitleKey: LangKeys.needRestocking,
      icon: Icons.warning_amber,
      imagePath: context.assets.lowStockInDashBoardScreen,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.lowStock,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.expiringSoon,
      value: '${summary.expiringSoonItems}',
      subtitleKey: LangKeys.itemsExpiringSoon,
      icon: Icons.schedule,
      imagePath: context.assets.expiringSoonInDashBoardScreen,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.expiringSoon,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.expiredItems,
      value: '${summary.expiredItems}',
      subtitleKey: LangKeys.removeFromStock,
      icon: Icons.error_outline,
      imagePath: context.assets.expiredItemsInDashBoardScreen,
      route: AppRoutes.inventoryAlertsByType(
        InventoryAlertFilterValues.expired,
      ),
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.totalRevenue,
      value: '\$${summary.totalRevenue.toStringAsFixed(2)}',
      subtitleKey: LangKeys.allTime,
      icon: Icons.attach_money,
      imagePath: context.assets.totalRevenueInDashBoardScreen,
      route: AppRoutes.reports,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.pendingPrescriptions,
      value: '${summary.pendingPrescriptions}',
      subtitleKey: LangKeys.awaitingReview,
      icon: Icons.receipt_long,
      imagePath: context.assets.pendingPrescriptionsInDashBoardScreen,
      route: AppRoutes.prescriptions,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.activeStaff,
      value: '${summary.activeStaff}',
      subtitleKey: LangKeys.acrossAllBranches,
      icon: Icons.people,
      imagePath: context.assets.staff,
      route: AppRoutes.staff,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.stockInToday,
      value: '${summary.stockInToday}',
      subtitleKey: LangKeys.itemsAddedToday,
      icon: Icons.trending_up,
      imagePath: context.assets.stockInInDashBoardScreen,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.stockOutToday,
      value: '${summary.stockOutToday}',
      subtitleKey: LangKeys.itemsRemovedToday,
      icon: Icons.trending_down,
      imagePath: context.assets.stockOutInDashBoardScreen,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.manualAdjustmentsToday,
      value: '${summary.manualAdjustmentsToday}',
      subtitleKey: LangKeys.adjustmentsToday,
      icon: Icons.tune,
      imagePath: context.assets.manualAdjustmentInDashBoardScreen,
      route: AppRoutes.stockHistory,
    ),
    DashboardSummaryCardData(
      titleKey: LangKeys.pendingOrders,
      value: '${summary.pendingOrders}',
      subtitleKey: LangKeys.awaitingProcessing,
      icon: Icons.shopping_bag_outlined,
      imagePath: context.assets.manualAdjustmentInDashBoardScreen,
      route: AppRoutes.orders,
    ),
  ];
}
