import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../widgets/reports_branch_filter.dart';
import '../widgets/reports_chart_card.dart';
import '../widgets/reports_stat_card.dart';

class ReportsBody extends StatelessWidget {
  const ReportsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportsCubit, ReportsState>(
      listenWhen: (previous, current) => current is ReportsFailure,
      listener: (context, state) {
        if (state is ReportsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return const AppLoading();
          }

          if (state is ReportsFailure) {
            return _ReportsErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<ReportsCubit>().getReports();
              },
            );
          }

          if (state is! ReportsLoaded) {
            return const SizedBox.shrink();
          }

          final summary = state.summary;

          return RefreshIndicator(
            onRefresh: context.read<ReportsCubit>().refreshReports,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 720;

                      if (wide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _FeatureHeader(
                                title: context.translate(
                                  LangKeys.reportsAndAnalytics,
                                ),
                                subtitle: context.translate(
                                  LangKeys
                                      .businessIntelligenceAcrossAllBranches,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            ReportsBranchFilter(
                              branches: state.branches,
                              value: state.selectedBranchId,
                              onChanged: context
                                  .read<ReportsCubit>()
                                  .updateBranch,
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FeatureHeader(
                            title: context.translate(
                              LangKeys.reportsAndAnalytics,
                            ),
                            subtitle: context.translate(
                              LangKeys.businessIntelligenceAcrossAllBranches,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ReportsBranchFilter(
                            branches: state.branches,
                            value: state.selectedBranchId,
                            onChanged: context
                                .read<ReportsCubit>()
                                .updateBranch,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 14.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final count = constraints.maxWidth >= 1100
                          ? 4
                          : constraints.maxWidth >= 650
                          ? 2
                          : 1;

                      return GridView.count(
                        crossAxisCount: count,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: count == 1 ? 3.2 : 2.25,
                        children: [
                          ReportsStatCard(
                            title: context.translate(LangKeys.totalRevenue),
                            value:
                                '\$${summary.totalRevenue.toStringAsFixed(2)}',
                            icon: Icons.attach_money,
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
                            title: context.translate(LangKeys.prescriptions),
                            value: '${summary.prescriptionsCount}',
                            icon: Icons.receipt_long,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  ReportsChartCard(
                    title: context.translate(LangKeys.dailyRevenueLast30Days),
                    data: summary.dailyRevenue,
                  ),
                  SizedBox(height: 16.h),
                  ReportsChartCard(
                    title: context.translate(LangKeys.revenueByBranch),
                    data: summary.revenueByBranch,
                  ),
                  SizedBox(height: 16.h),
                  ReportsChartCard(
                    title: context.translate(LangKeys.paymentMethods),
                    data: summary.paymentMethods,
                  ),
                  SizedBox(height: 16.h),
                  ReportsChartCard(
                    title: context.translate(LangKeys.orderStatusBreakdown),
                    data: summary.orderStatusBreakdown,
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

class _ReportsErrorView extends StatelessWidget {
  const _ReportsErrorView({required this.message, required this.onRetry});

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
