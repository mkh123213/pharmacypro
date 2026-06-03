import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

enum AppStatusChipType { success, error, warning, info, neutral, primary }

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.label,
    this.type = AppStatusChipType.neutral,
    this.color,
    super.key,
  });

  final String label;
  final AppStatusChipType type;
  final Color? color;

  Color _statusColor(BuildContext context) {
    if (color != null) return color!;

    final colors = context.color;
    switch (type) {
      case AppStatusChipType.success:
        return colors.success;
      case AppStatusChipType.error:
        return colors.error;
      case AppStatusChipType.warning:
        return colors.warning;
      case AppStatusChipType.info:
        return colors.info;
      case AppStatusChipType.primary:
        return colors.primary;
      case AppStatusChipType.neutral:
        return colors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = _statusColor(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: chipColor.withOpacity(0.18)),
      ),
      child: TextApp(
        text: label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        theme: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: chipColor,
          height: 1.2,
        ),
      ),
    );
  }
}
