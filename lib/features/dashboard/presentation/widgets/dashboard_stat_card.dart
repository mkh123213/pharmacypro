import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    required this.title,
    required this.value,

    this.imagePath,
    this.subtitle,
    this.color,
    this.onTap,
    super.key,
  });

  final String title;
  final String value;
  final String? subtitle;

  /// Optional illustration shown instead of [icon] when provided.
  final String? imagePath;
  final Color? color;
  final VoidCallback? onTap;

  Widget _buildLeading(Color cardColor) {
    final radius = BorderRadius.circular(14.r);

    // These illustrations ship with their own baked-in background, so we clip
    // them to the rounded box instead of placing them on a tinted container.
    if (imagePath != null) {
      return AppImageAssetPreviewer(imagePath!, radius: radius, width: 45.w);
    }

    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.10),
        borderRadius: radius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final radius = BorderRadius.circular(18.r);
    final cardColor = color ?? colors.primary;

    return Material(
      color: colors.background,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          constraints: BoxConstraints(minHeight: 96.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              _buildLeading(cardColor),
              SizedBox(width: 10.w),
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
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),
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
                              fontSize: 22.sp,
                              height: 1,
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      TextApp(
                        text: subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(
                          fontSize: 11.sp,
                          height: 1.1,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
