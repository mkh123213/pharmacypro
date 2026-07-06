part of 'reports_body.dart';

class _ReportsCharts extends StatelessWidget {
  const _ReportsCharts({required this.summary});

  final ReportsSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final charts = [
      ReportsChartCard(
        title: context.translate(LangKeys.inventoryHealthSummary),
        data: summary.inventoryHealthSummary,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.dailyRevenueLast30Days),
        data: summary.dailyRevenue,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.dailyProfitLast30Days),
        data: summary.dailyProfit,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.revenueByBranch),
        data: summary.revenueByBranch,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.topSellingMedications),
        data: summary.topSellingMedications,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.topProfitableMedications),
        data: summary.topProfitableMedications,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.paymentMethods),
        data: summary.paymentMethods,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.orderStatusBreakdown),
        data: summary.orderStatusBreakdown,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.stockMovementByType),
        data: summary.stockMovementByType,
      ),
      ReportsChartCard(
        title: context.translate(LangKeys.mostMovedMedications),
        data: summary.mostMovedMedications,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 920;

        if (!twoColumns) {
          return Column(
            children: [
              for (var index = 0; index < charts.length; index++) ...[
                charts[index],
                if (index != charts.length - 1) SizedBox(height: 16.h),
              ],
            ],
          );
        }

        final itemWidth = (constraints.maxWidth - 12.w) / 2;

        return Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            for (final chart in charts)
              SizedBox(width: itemWidth, child: chart),
          ],
        );
      },
    );
  }
}
