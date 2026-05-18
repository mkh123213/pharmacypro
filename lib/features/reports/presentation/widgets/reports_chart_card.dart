import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/report_chart_model.dart';

class ReportsChartCard extends StatelessWidget {
  const ReportsChartCard({required this.title, required this.data, super.key});

  final String title;
  final List<ReportChartModel> data;

  @override
  Widget build(BuildContext context) {
    final max = data.fold<double>(
      0,
      (maxValue, item) => item.value > maxValue ? item.value : maxValue,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    final progress = max == 0 ? 0.0 : item.value / max;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth < 330 ? 72.w : 100.w,
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
                              value: progress.clamp(0.0, 1.0),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 64.w),
                            child: TextApp(
                              text: item.value.toStringAsFixed(0),
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
