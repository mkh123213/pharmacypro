import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

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

  Color get _statusColor {
    if (color != null) return color!;

    switch (type) {
      case AppStatusChipType.success:
        return AppColors.success;
      case AppStatusChipType.error:
        return AppColors.error;
      case AppStatusChipType.warning:
        return AppColors.warning;
      case AppStatusChipType.info:
        return AppColors.info;
      case AppStatusChipType.primary:
        return AppColors.primary;
      case AppStatusChipType.neutral:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = _statusColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: chipColor.withOpacity(0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: chipColor,
          height: 1.2,
        ),
      ),
    );
  }
}
