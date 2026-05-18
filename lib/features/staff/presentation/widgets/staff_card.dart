import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/staff_model.dart';
import '../refactor/staff_constants.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({
    required this.staff,
    required this.onEditPressed,
    super.key,
  });

  final StaffModel staff;
  final VoidCallback onEditPressed;

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
                        theme: context.textStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      AppStatusChip(
                        label: formatStaffRole(context, staff.role),
                        type: roleChipType(staff.role),
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
                      theme: context.textStyle,
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
    return name
        .trim()
        .split(RegExp(r'\s+'))
        .where((item) => item.isNotEmpty)
        .map((item) => item[0])
        .take(2)
        .join()
        .toUpperCase();
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: Colors.grey.shade600),
          SizedBox(width: 7.w),
          Expanded(
            child: TextApp(
              text: text,
              theme: context.textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
