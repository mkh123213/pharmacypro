part of 'reports_body.dart';

class _ReportsHeader extends StatelessWidget {
  const _ReportsHeader({required this.state});

  final ReportsLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;

        final title = _FeatureHeader(
          title: context.translate(LangKeys.reportsAndAnalytics),
          subtitle: state.isRefreshing
              ? context.translate(LangKeys.refreshing)
              : context.translate(
                  LangKeys.businessIntelligenceAcrossAllBranches,
                ),
          action: AppPrimaryButton(
            text: context.translate(LangKeys.refresh),
            icon: Icons.refresh,
            isLoading: state.isRefreshing,
            onPressed: state.isRefreshing
                ? null
                : () {
                    context.read<ReportsCubit>().refreshReports();
                  },
          ),
        );

        final filter = ReportsBranchFilter(
          branches: state.branches,
          value: state.selectedBranchId,
          isEnabled: !state.isRefreshing,
          onChanged: context.read<ReportsCubit>().updateBranch,
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: title),
              SizedBox(width: 12.w),
              filter,
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(height: 12.h),
            filter,
          ],
        );
      },
    );
  }
}
