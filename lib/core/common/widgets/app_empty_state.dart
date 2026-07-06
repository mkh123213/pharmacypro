import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    required this.message,
    required this.imagePath,
    this.action,
    super.key,
  });

  final String title;
  final String message;
  final String imagePath;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImageAssetPreviewer(imagePath, width: 64.w),
            SizedBox(height: 16.h),
            TextApp(
              text: title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
            ),
            if (action != null) ...[SizedBox(height: 18.h), action!],
          ],
        ),
      ),
    );
  }
}
