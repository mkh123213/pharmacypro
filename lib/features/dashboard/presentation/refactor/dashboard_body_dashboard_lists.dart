part of 'dashboard_body.dart';

class _DashboardLists extends StatelessWidget {
  const _DashboardLists({required this.summary});

  final DashboardSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1000;

        final lowStock = LowStockItemsCard(items: summary.lowStockItems);
        final orders = RecentOrdersCard(orders: summary.orders);
        final movements = RecentStockMovementsCard(
          movements: summary.recentStockMovements,
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: lowStock),
              SizedBox(width: 12.w),
              Expanded(child: orders),
              SizedBox(width: 12.w),
              Expanded(child: movements),
            ],
          );
        }

        return Column(
          children: [
            lowStock,
            SizedBox(height: 16.h),
            orders,
            SizedBox(height: 16.h),
            movements,
          ],
        );
      },
    );
  }
}
