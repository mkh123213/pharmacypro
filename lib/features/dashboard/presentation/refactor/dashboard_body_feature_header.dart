part of 'dashboard_body.dart';

class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({
    required this.title,
    required this.subtitle,
    required this.isRefreshing,
    this.action,
  });

  final String title;
  final String subtitle;
  final bool isRefreshing;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;

        final titleColumn = Column(
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
              text: isRefreshing
                  ? context.translate(LangKeys.refreshing)
                  : subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ],
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleColumn,
              if (action != null) ...[
                SizedBox(height: 12.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: action!,
                ),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleColumn),
            if (action != null) ...[SizedBox(width: 12.w), action!],
          ],
        );
      },
    );
  }
}
