import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/branch_model.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    required this.branch,
    required this.onEditPressed,
    super.key,
  });

  final BranchModel branch;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 19.r,
                  backgroundColor: primary.withAlpha(25),
                  child: Icon(
                    Icons.store_outlined,
                    size: 20.sp,
                    color: primary,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextApp(
                    text: branch.name,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  tooltip: context.translate(LangKeys.edit),
                  onPressed: onEditPressed,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  icon: Icon(Icons.edit_outlined, size: 19.sp),
                ),
              ],
            ),
            if ((branch.city ?? '').trim().isNotEmpty) ...[
              SizedBox(height: 4.h),
              TextApp(
                text: branch.city!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
            SizedBox(height: 8.h),
            _Info(icon: Icons.location_on_outlined, text: branch.address),
            if ((branch.phone ?? '').trim().isNotEmpty)
              _Info(icon: Icons.phone_outlined, text: branch.phone!),
            if ((branch.email ?? '').trim().isNotEmpty)
              _Info(icon: Icons.mail_outline, text: branch.email!),
            if ((branch.managerName ?? '').trim().isNotEmpty)
              _Info(icon: Icons.person_outline, text: branch.managerName!),
            if ((branch.openingHours ?? '').trim().isNotEmpty)
              _Info(icon: Icons.schedule_outlined, text: branch.openingHours!),
            SizedBox(height: 8.h),
            AppStatusChip(
              label: branch.isActive
                  ? context.translate(LangKeys.active)
                  : context.translate(LangKeys.inactive),
              type: branch.isActive
                  ? AppStatusChipType.success
                  : AppStatusChipType.error,
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14.sp, color: context.color.textSecondary),
          SizedBox(width: 7.w),
          Expanded(
            child: TextApp(
              text: text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
