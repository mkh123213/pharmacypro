import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/dashboard_chart_card.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/low_stock_items_card.dart';
import '../widgets/recent_orders_card.dart';

class DashboardBody extends StatelessWidget { const DashboardBody({super.key}); @override Widget build(BuildContext context) => BlocBuilder<DashboardCubit, DashboardState>(builder: (context, state) { if (state is DashboardLoading) return const Center(child: CircularProgressIndicator()); if (state is DashboardFailure) return Center(child: Text(state.message)); if (state is! DashboardLoaded) return const SizedBox.shrink(); final s = state.summary; return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Dashboard', subtitle: 'Overview for today'), const SizedBox(height: 14), LayoutBuilder(builder: (context, c) { final count = c.maxWidth > 800 ? 4 : 2; return GridView.count(crossAxisCount: count, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2, children: [DashboardStatCard(title: 'Total Revenue', value: '\$${s.totalRevenue.toStringAsFixed(2)}', subtitle: 'All time', icon: Icons.attach_money), DashboardStatCard(title: 'Low Stock Alerts', value: '${s.lowStockItems.length}', subtitle: 'Need restocking', icon: Icons.warning_amber), DashboardStatCard(title: 'Pending Prescriptions', value: '${s.pendingPrescriptions}', subtitle: 'Awaiting review', icon: Icons.receipt_long), DashboardStatCard(title: 'Active Staff', value: '${s.activeStaff}', subtitle: 'Across all branches', icon: Icons.people)]); }), const SizedBox(height: 16), DashboardChartCard(title: 'Revenue - Last 7 Days', data: s.last7Days, valueBuilder: (e) => e.revenue), const SizedBox(height: 16), DashboardChartCard(title: 'Sales Count - Last 7 Days', data: s.last7Days, valueBuilder: (e) => e.count.toDouble()), const SizedBox(height: 16), LowStockItemsCard(items: s.lowStockItems), const SizedBox(height: 16), RecentOrdersCard(orders: s.orders)])); }); }


class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({required this.title, required this.subtitle, this.action});
  final String title;
  final String subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Colors.grey.shade600))])), if (action != null) action!]);
}
