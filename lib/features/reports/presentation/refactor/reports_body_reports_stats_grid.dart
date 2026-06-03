part of 'reports_body.dart';

class _ReportsStatsGrid extends StatelessWidget {
  const _ReportsStatsGrid({required this.summary});

  final ReportsSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final cards = [
      ReportsStatCard(
        title: context.translate(LangKeys.totalRevenue),
        value: '\$${summary.totalRevenue.toStringAsFixed(2)}',
        icon: Icons.attach_money,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalCost),
        value: '\$${summary.totalCost.toStringAsFixed(2)}',
        icon: Icons.money_off,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalProfit),
        value: '\$${summary.totalProfit.toStringAsFixed(2)}',
        icon: Icons.trending_up,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.profitMargin),
        value: '${summary.profitMarginPercent.toStringAsFixed(1)}%',
        icon: Icons.pie_chart,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalSales),
        value: '${summary.totalSalesCount}',
        icon: Icons.point_of_sale,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.customerOrders),
        value: '${summary.totalOrders}',
        icon: Icons.shopping_cart,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.lowStockItems),
        value: '${summary.lowStockItems}',
        icon: Icons.inventory_2,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.expiringSoon),
        value: '${summary.expiringSoonItems}',
        icon: Icons.schedule,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.expiredItems),
        value: '${summary.expiredItems}',
        icon: Icons.error_outline,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.healthyStock),
        value: '${summary.healthyStockItems}',
        icon: Icons.check_circle_outline,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.prescriptions),
        value: '${summary.prescriptionsCount}',
        icon: Icons.receipt_long,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.stockIn),
        value: '${summary.totalStockIn}',
        icon: Icons.arrow_upward,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.stockOut),
        value: '${summary.totalStockOut}',
        icon: Icons.arrow_downward,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.manualAdjustments),
        value: '${summary.manualAdjustmentsCount}',
        icon: Icons.tune,
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
            childAspectRatio: count == 1 ? 3.2 : 2.1,
          ),
          itemBuilder: (_, index) {
            return cards[index];
          },
        );
      },
    );
  }
}
