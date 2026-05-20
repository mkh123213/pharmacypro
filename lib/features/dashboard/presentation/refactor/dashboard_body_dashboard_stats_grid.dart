part of 'dashboard_body.dart';

class _DashboardStatsGrid extends StatelessWidget {
  const _DashboardStatsGrid({required this.summary});

  final DashboardSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final cards = [
      DashboardStatCard(
        title: context.translate(LangKeys.lowStockAlerts),
        value: '${summary.lowStockItems.length}',
        subtitle: context.translate(LangKeys.needRestocking),
        icon: Icons.warning_amber,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.expiringSoon),
        value: '${summary.expiringSoonItems}',
        subtitle: context.translate(LangKeys.itemsExpiringSoon),
        icon: Icons.schedule,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.expiredItems),
        value: '${summary.expiredItems}',
        subtitle: context.translate(LangKeys.removeFromStock),
        icon: Icons.error_outline,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.totalRevenue),
        value: '\$${summary.totalRevenue.toStringAsFixed(2)}',
        subtitle: context.translate(LangKeys.allTime),
        icon: Icons.attach_money,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.pendingPrescriptions),
        value: '${summary.pendingPrescriptions}',
        subtitle: context.translate(LangKeys.awaitingReview),
        icon: Icons.receipt_long,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.activeStaff),
        value: '${summary.activeStaff}',
        subtitle: context.translate(LangKeys.acrossAllBranches),
        icon: Icons.people,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.stockInToday),
        value: '${summary.stockInToday}',
        subtitle: context.translate(LangKeys.itemsAddedToday),
        icon: Icons.trending_up,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.stockOutToday),
        value: '${summary.stockOutToday}',
        subtitle: context.translate(LangKeys.itemsRemovedToday),
        icon: Icons.trending_down,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.manualAdjustmentsToday),
        value: '${summary.manualAdjustmentsToday}',
        subtitle: context.translate(LangKeys.adjustmentsToday),
        icon: Icons.tune,
      ),
      DashboardStatCard(
        title: context.translate(LangKeys.pendingOrders),
        value: '${summary.pendingOrders}',
        subtitle: context.translate(LangKeys.awaitingProcessing),
        icon: Icons.shopping_bag_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1200
            ? 4
            : constraints.maxWidth >= 800
            ? 3
            : constraints.maxWidth >= 520
            ? 2
            : 1;

        return GridView.builder(
          itemCount: cards.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: count == 1 ? 3.15 : 2.1,
          ),
          itemBuilder: (_, index) {
            return cards[index];
          },
        );
      },
    );
  }
}
