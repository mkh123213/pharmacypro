import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../data/models/shift_model.dart';
import '../refactor/shifts_constants.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    required this.shift,
    required this.onTap,
    this.isSubmitting = false,
    super.key,
  });

  final ShiftModel shift;
  final VoidCallback onTap;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSubmitting ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextApp(
                text: shift.staffName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              TextApp(
                text: '${shift.startTime} - ${shift.endTime}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 6.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: AppStatusChip(
                  label: shiftStatusLabel(context, shift.status),
                  type: shiftStatusType(shift.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
