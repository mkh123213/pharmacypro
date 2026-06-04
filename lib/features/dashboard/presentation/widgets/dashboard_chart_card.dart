import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/dashboard_chart_model.dart';

class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({
    required this.title,
    required this.data,
    required this.valueBuilder,
    super.key,
  });

  final String title;
  final List<DashboardChartModel> data;
  final double Function(DashboardChartModel item) valueBuilder;

  @override
  Widget build(BuildContext context) {
    final max = data.fold<double>(0, (maxValue, item) {
      final value = valueBuilder(item);
      return value > maxValue ? value : maxValue;
    });

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 340;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextApp(
                  text: title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                if (data.isEmpty)
                  TextApp(
                    text: context.translate(LangKeys.noDataAvailable),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  )
                else
                  ListView.separated(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, _) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final value = valueBuilder(item);
                      final progressValue = max == 0 ? 0.0 : value / max;

                      return Row(
                        children: [
                          SizedBox(
                            width: compact ? 48.w : 64.w,
                            child: TextApp(
                              text: item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              theme: context.textStyle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999.r),
                              child: LinearProgressIndicator(
                                minHeight: 8.h,
                                value: progressValue.clamp(0.0, 1.0),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: compact ? 42.w : 56.w,
                            child: TextApp(
                              text: value.toStringAsFixed(0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              theme: context.textStyle,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
