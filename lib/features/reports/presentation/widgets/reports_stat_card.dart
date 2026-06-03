import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';

class ReportsStatCard extends StatelessWidget {
  const ReportsStatCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    text: title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontSize: 12.sp,
                      height: 1.1,
                      color: context.color.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 28.h,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: TextApp(
                          text: value,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          theme: context.textStyle.copyWith(
                            height: 1,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: primary.withOpacity(0.10),
              child: Icon(icon, color: primary, size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
