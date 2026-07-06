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
        imagePath: context.assets.totalRevenue,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalCost),
        value: '\$${summary.totalCost.toStringAsFixed(2)}',
        imagePath: context.assets.totalCost,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalProfit),
        value: '\$${summary.totalProfit.toStringAsFixed(2)}',
        imagePath: context.assets.totalProfit,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.profitMargin),
        value: '${summary.profitMarginPercent.toStringAsFixed(1)}%',
        imagePath: context.assets.totalMargin,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.totalSales),
        value: '${summary.totalSalesCount}',
        imagePath: context.assets.totalSales,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.customerOrders),
        value: '${summary.totalOrders}',
        imagePath: context.assets.customerOrders,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.lowStockItems),
        value: '${summary.lowStockItems}',
        imagePath: context.assets.lowStockItems,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.expiringSoon),
        value: '${summary.expiringSoonItems}',
        imagePath: context.assets.expiringSoon,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.expiredItems),
        value: '${summary.expiredItems}',
        imagePath: context.assets.expiredItems,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.healthyStock),
        value: '${summary.healthyStockItems}',
        imagePath: context.assets.healthyStock,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.prescriptions),
        value: '${summary.prescriptionsCount}',
        imagePath: context.assets.prescriptions,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.stockIn),
        value: '${summary.totalStockIn}',
        imagePath: context.assets.stockIn,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.stockOut),
        value: '${summary.totalStockOut}',
        imagePath: context.assets.stockOut,
      ),
      ReportsStatCard(
        title: context.translate(LangKeys.manualAdjustments),
        value: '${summary.manualAdjustmentsCount}',
        imagePath: context.assets.manualAdjustment,
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
