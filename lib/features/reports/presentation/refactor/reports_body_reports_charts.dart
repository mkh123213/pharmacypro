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
        title: context.translate(LangKeys.revenueByBranch),
        data: summary.revenueByBranch,
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

        return GridView.builder(
          itemCount: charts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.85,
          ),
          itemBuilder: (_, index) {
            return charts[index];
          },
        );
      },
    );
  }
}
