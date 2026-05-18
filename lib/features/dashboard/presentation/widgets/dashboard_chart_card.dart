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
                  ...data.map((item) {
                    final value = valueBuilder(item);
                    final progressValue = max == 0 ? 0.0 : value / max;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth < 320 ? 56.w : 72.w,
                            child: TextApp(
                              text: item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              theme: context.textStyle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progressValue.clamp(0.0, 1.0),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 56.w),
                            child: TextApp(
                              text: value.toStringAsFixed(0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              theme: context.textStyle,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }
}
