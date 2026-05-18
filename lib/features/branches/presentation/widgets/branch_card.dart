import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';
import 'package:pharmacypro/core/language/lang_keys.dart';

import '../../../../core/common/widgets/text_app.dart';
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
                    theme: context.textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
            if ((branch.city ?? '').isNotEmpty) ...[
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
            if ((branch.phone ?? '').isNotEmpty)
              _Info(icon: Icons.phone_outlined, text: branch.phone!),
            if ((branch.email ?? '').isNotEmpty)
              _Info(icon: Icons.mail_outline, text: branch.email!),
            if ((branch.managerName ?? '').isNotEmpty)
              _Info(icon: Icons.person_outline, text: branch.managerName!),
            if ((branch.openingHours ?? '').isNotEmpty)
              _Info(icon: Icons.schedule_outlined, text: branch.openingHours!),
            SizedBox(height: 8.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Chip(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                label: TextApp(
                  text: branch.isActive
                      ? context.translate(LangKeys.open)
                      : context.translate(LangKeys.closed),
                  theme: context.textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                backgroundColor: branch.isActive
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                side: BorderSide(
                  color: branch.isActive
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
              ),
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
          Icon(icon, size: 14.sp, color: Colors.grey),
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
