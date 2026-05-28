import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/staff_model.dart';
import '../refactor/staff_constants.dart';

part 'staff_card_info.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({
    required this.staff,
    required this.onEditPressed,
    required this.onDeletePressed,
    super.key,
  });

  final StaffModel staff;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: primary.withOpacity(.12),
                  child: TextApp(
                    text: _initials(staff.fullName),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextApp(
                        text: staff.fullName,
                        theme: context.textStyle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: AppStatusChip(
                          label: formatStaffRole(context, staff.role),
                          type: roleChipType(staff.role),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onEditPressed,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  icon: Icon(Icons.edit_outlined, size: 19.sp),
                ),
                IconButton(
                  onPressed: onDeletePressed,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  icon: Icon(Icons.delete_outline, size: 19.sp, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            if (staff.email.isNotEmpty)
              _Info(icon: Icons.mail_outline, text: staff.email),
            if ((staff.phone ?? '').isNotEmpty)
              _Info(icon: Icons.phone_outlined, text: staff.phone!),
            if ((staff.branchName ?? '').isNotEmpty)
              _Info(icon: Icons.store_outlined, text: staff.branchName!),
            SizedBox(height: 10.h),
            Row(
              children: [
                AppStatusChip(
                  label: staff.isActive
                      ? context.translate(LangKeys.active)
                      : context.translate(LangKeys.inactive),
                  type: staff.isActive
                      ? AppStatusChipType.success
                      : AppStatusChipType.error,
                ),
                const Spacer(),
                if ((staff.hireDate ?? '').isNotEmpty)
                  Flexible(
                    child: TextApp(
                      text: staff.hireDate!,
                      theme: context.textStyle.copyWith(fontSize: 12.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((item) => item.isNotEmpty)
        .map((item) => item[0])
        .take(2)
        .join()
        .toUpperCase();

    if (initials.isEmpty) return '?';

    return initials;
  }
}
