import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/dashboard_summary_model.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/dashboard_chart_card.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/low_stock_items_card.dart';
import '../widgets/recent_orders_card.dart';
import '../widgets/recent_stock_movements_card.dart';

part 'dashboard_body_dashboard_charts.dart';
part 'dashboard_body_dashboard_error_view.dart';
part 'dashboard_body_dashboard_lists.dart';
part 'dashboard_body_dashboard_stats_grid.dart';
part 'dashboard_body_feature_header.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listenWhen: (previous, current) {
        if (current is DashboardFailure) return true;

        if (current is DashboardLoaded && current.errorMessage != null) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        if (state is DashboardFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }

        if (state is DashboardLoaded && state.errorMessage != null) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.errorMessage!),
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
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeatureHeader(
                    title: context.translate(LangKeys.dashboard),
                    subtitle: context.translate(LangKeys.overviewForToday),
                    isRefreshing: state.isRefreshing,
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.refresh),
                      icon: Icons.refresh,
                      isLoading: state.isRefreshing,
                      onPressed: state.isRefreshing
                          ? null
                          : () {
                              context.read<DashboardCubit>().refreshDashboard();
                            },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _DashboardStatsGrid(summary: summary),
                  SizedBox(height: 16.h),
                  _DashboardCharts(summary: summary),
                  SizedBox(height: 16.h),
                  _DashboardLists(summary: summary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
