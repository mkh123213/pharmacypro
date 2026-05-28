part of 'dashboard_body.dart';

class _DashboardCharts extends StatelessWidget {
  const _DashboardCharts({required this.summary});

  final DashboardSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final revenueChart = DashboardChartCard(
          title: context.translate(LangKeys.revenueLast7Days),
          data: summary.last7Days,
          valueBuilder: (item) => item.revenue,
        );

        final salesChart = DashboardChartCard(
          title: context.translate(LangKeys.salesCountLast7Days),
          data: summary.last7Days,
          valueBuilder: (item) => item.count.toDouble(),
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: revenueChart),
              SizedBox(width: 12.w),
              Expanded(child: salesChart),
            ],
          );
        }

        return Column(
          children: [
            revenueChart,
            SizedBox(height: 16.h),
            salesChart,
          ],
        );
      },
    );
  }
}
