import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/reports_summary_model.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../widgets/reports_branch_filter.dart';
import '../widgets/reports_chart_card.dart';
import '../widgets/reports_stat_card.dart';

part 'reports_body_feature_header.dart';
part 'reports_body_reports_charts.dart';
part 'reports_body_reports_error_view.dart';
part 'reports_body_reports_header.dart';
part 'reports_body_reports_stats_grid.dart';

class ReportsBody extends StatelessWidget {
  const ReportsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportsCubit, ReportsState>(
      listenWhen: (previous, current) {
        if (current is ReportsFailure) return true;

        if (current is ReportsLoaded && current.errorMessage != null) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        if (state is ReportsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }

        if (state is ReportsLoaded && state.errorMessage != null) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.errorMessage!),
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

          return RefreshIndicator(
            onRefresh: context.read<ReportsCubit>().refreshReports,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReportsHeader(state: state),
                  SizedBox(height: 14.h),
                  _ReportsStatsGrid(summary: state.summary),
                  SizedBox(height: 16.h),
                  _ReportsCharts(summary: state.summary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
