import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import 'text_app.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    required this.message,
    this.icon,
    this.action,
    super.key,
  });

  final String title;
  final String message;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 30.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            TextApp(
              text: title,
              textAlign: TextAlign.center,
              theme: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              theme: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            if (action != null) ...[SizedBox(height: 18.h), action!],
          ],
        ),
      ),
    );
  }
}
