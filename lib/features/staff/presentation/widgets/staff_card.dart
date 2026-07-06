import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

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
                  backgroundColor: primary.withValues(alpha: .12),
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
                          roleImagePath: formatStaffImagePath(
                            context,
                            staff.role,
                          ),
                          label: formatStaffRole(context, staff.role),
                          type: roleChipType(staff.role),
                        ),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: context.translate(LangKeys.delete),
                  child: GestureDetector(
                    onTap: () => onDeletePressed,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AppImageAssetPreviewer(
                        context.assets.delete,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                ),
                Tooltip(
                  message: context.translate(LangKeys.delete),
                  child: GestureDetector(
                    onTap: () => onDeletePressed,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AppImageAssetPreviewer(
                        context.assets.delete,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
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
