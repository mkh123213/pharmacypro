import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../widgets/reports_branch_filter.dart';
import '../widgets/reports_chart_card.dart';
import '../widgets/reports_stat_card.dart';

class ReportsBody extends StatelessWidget {
  const ReportsBody({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<ReportsCubit, ReportsState>(
    builder: (context, state) {
      if (state is ReportsLoading)
        return const Center(child: CircularProgressIndicator());
      if (state is ReportsFailure) return Center(child: Text(state.message));
      if (state is! ReportsLoaded) return const SizedBox.shrink();
      final s = state.summary;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: _FeatureHeader(
                    title: 'Reports & Analytics',
                    subtitle: 'Business intelligence across all branches',
                  ),
                ),
                ReportsBranchFilter(
                  branches: state.branches,
                  value: state.selectedBranchId,
                  onChanged: context.read<ReportsCubit>().updateBranch,
                ),
              ],
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, c) {
                final count = c.maxWidth > 800 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: count,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                  children: [
                    ReportsStatCard(
                      title: 'Total Revenue',
                      value: '\$${s.totalRevenue.toStringAsFixed(2)}',
                      icon: Icons.attach_money,
                    ),
                    ReportsStatCard(
                      title: 'Customer Orders',
                      value: '${s.totalOrders}',
                      icon: Icons.shopping_cart,
                    ),
                    ReportsStatCard(
                      title: 'Low Stock Items',
                      value: '${s.lowStockItems}',
                      icon: Icons.inventory_2,
                    ),
                    ReportsStatCard(
                      title: 'Prescriptions',
                      value: '${s.prescriptionsCount}',
                      icon: Icons.receipt_long,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            ReportsChartCard(
              title: 'Daily Revenue - Last 30 Days',
              data: s.dailyRevenue,
            ),
            const SizedBox(height: 16),
            ReportsChartCard(
              title: 'Revenue by Branch',
              data: s.revenueByBranch,
            ),
            const SizedBox(height: 16),
            ReportsChartCard(title: 'Payment Methods', data: s.paymentMethods),
            const SizedBox(height: 16),
            ReportsChartCard(
              title: 'Order Status Breakdown',
              data: s.orderStatusBreakdown,
            ),
          ],
        ),
      );
    },
  );
}

class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({
    required this.title,
    required this.subtitle,
    this.action,
  });
  final String title;
  final String subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
      if (action != null) action!,
    ],
  );
}
