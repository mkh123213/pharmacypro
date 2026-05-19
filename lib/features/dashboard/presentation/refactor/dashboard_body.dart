import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/features/dashboard/presentation/widgets/recent_stock_movements_card.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/dashboard_chart_card.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/low_stock_items_card.dart';
import '../widgets/recent_orders_card.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listenWhen: (previous, current) => current is DashboardFailure,
      listener: (context, state) {
        if (state is DashboardFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const AppLoading();
          }

          if (state is DashboardFailure) {
            return _DashboardErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<DashboardCubit>().getDashboardSummary();
              },
            );
          }

          if (state is! DashboardLoaded) {
            return const SizedBox.shrink();
          }

          final summary = state.summary;

          return RefreshIndicator(
            onRefresh: context.read<DashboardCubit>().refreshDashboard,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeatureHeader(
                    title: context.translate(LangKeys.dashboard),
                    subtitle: context.translate(LangKeys.overviewForToday),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.refresh),
                      icon: Icons.refresh,
                      onPressed: () {
                        context.read<DashboardCubit>().refreshDashboard();
                      },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final count = constraints.maxWidth >= 1200
                          ? 4
                          : constraints.maxWidth >= 700
                          ? 2
                          : 1;

                      return GridView.count(
                        crossAxisCount: count,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: count == 1 ? 3.1 : 2.25,
                        children: [
                          DashboardStatCard(
                            title: context.translate(LangKeys.totalRevenue),
                            value:
                                '\$${summary.totalRevenue.toStringAsFixed(2)}',
                            subtitle: context.translate(LangKeys.allTime),
                            icon: Icons.attach_money,
                          ),
                          DashboardStatCard(
                            title: context.translate(LangKeys.lowStockAlerts),
                            value: '${summary.lowStockItems.length}',
                            subtitle: context.translate(
                              LangKeys.needRestocking,
                            ),
                            icon: Icons.warning_amber,
                          ),
                          DashboardStatCard(
                            title: context.translate(
                              LangKeys.pendingPrescriptions,
                            ),
                            value: '${summary.pendingPrescriptions}',
                            subtitle: context.translate(
                              LangKeys.awaitingReview,
                            ),
                            icon: Icons.receipt_long,
                          ),
                          DashboardStatCard(
                            title: context.translate(LangKeys.activeStaff),
                            value: '${summary.activeStaff}',
                            subtitle: context.translate(
                              LangKeys.acrossAllBranches,
                            ),
                            icon: Icons.people,
                          ),
                          DashboardStatCard(
                            title: context.translate(LangKeys.stockInToday),
                            value: '${summary.stockInToday}',
                            subtitle: context.translate(
                              LangKeys.itemsAddedToday,
                            ),
                            icon: Icons.trending_up,
                          ),
                          DashboardStatCard(
                            title: context.translate(LangKeys.stockOutToday),
                            value: '${summary.stockOutToday}',
                            subtitle: context.translate(
                              LangKeys.itemsRemovedToday,
                            ),
                            icon: Icons.trending_down,
                          ),
                          DashboardStatCard(
                            title: context.translate(
                              LangKeys.manualAdjustmentsToday,
                            ),
                            value: '${summary.manualAdjustmentsToday}',
                            subtitle: context.translate(
                              LangKeys.adjustmentsToday,
                            ),
                            icon: Icons.tune,
                          ),
                          DashboardStatCard(
                            title: context.translate(LangKeys.pendingOrders),
                            value: '${summary.pendingOrders}',
                            subtitle: context.translate(
                              LangKeys.awaitingProcessing,
                            ),
                            icon: Icons.shopping_bag_outlined,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  DashboardChartCard(
                    title: context.translate(LangKeys.revenueLast7Days),
                    data: summary.last7Days,
                    valueBuilder: (item) => item.revenue,
                  ),
                  SizedBox(height: 16.h),
                  DashboardChartCard(
                    title: context.translate(LangKeys.salesCountLast7Days),
                    data: summary.last7Days,
                    valueBuilder: (item) => item.count.toDouble(),
                  ),
                  SizedBox(height: 16.h),
                  LowStockItemsCard(items: summary.lowStockItems),
                  SizedBox(height: 16.h),
                  RecentOrdersCard(orders: summary.orders),
                  SizedBox(height: 16.h),
                  RecentStockMovementsCard(
                    movements: summary.recentStockMovements,
                  ),
                  SizedBox(height: 16.h),
                  RecentOrdersCard(orders: summary.orders),
                  SizedBox(height: 16.h),
                  RecentStockMovementsCard(
                    movements: summary.recentStockMovements,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
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
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 4.h),
              TextApp(
                text: subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        ),
        if (action != null) ...[SizedBox(width: 12.w), action!],
      ],
    );
  }
}

class _DashboardErrorView extends StatelessWidget {
  const _DashboardErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.red.shade400),
            SizedBox(height: 12.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 16.h),
            AppPrimaryButton(
              text: context.translate(LangKeys.retry),
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
