import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/staff_model.dart';
import '../refactor/staff_constants.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({required this.staff, required this.onEditPressed, super.key});
  final StaffModel staff;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return AppCard(child: Padding(padding: EdgeInsets.all(18.w), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(backgroundColor: primary.withOpacity(.12), child: Text(_initials(staff.fullName), style: TextStyle(color: primary, fontWeight: FontWeight.w700))),
        SizedBox(width: 12.w),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextApp(text: staff.fullName, theme: Theme.of(context).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          AppStatusChip(label: formatStaffRole(staff.role), type: roleChipType(staff.role)),
        ])),
        IconButton(onPressed: onEditPressed, icon: Icon(Icons.edit_outlined, size: 20.sp)),
      ]),
      SizedBox(height: 12.h),
      if (staff.email.isNotEmpty) _Info(icon: Icons.mail_outline, text: staff.email),
      if ((staff.phone ?? '').isNotEmpty) _Info(icon: Icons.phone_outlined, text: staff.phone!),
      if ((staff.branchName ?? '').isNotEmpty) _Info(icon: Icons.store_outlined, text: staff.branchName!),
      const Spacer(),
      Row(children: [
        AppStatusChip(label: staff.isActive ? 'Active' : 'Inactive', type: staff.isActive ? AppStatusChipType.success : AppStatusChipType.error),
        const Spacer(),
        if ((staff.hireDate ?? '').isNotEmpty) TextApp(text: 'Since ${staff.hireDate}', theme: Theme.of(context).textTheme.bodySmall),
      ]),
    ])));
  }

  String _initials(String name) => name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).map((e) => e[0]).take(2).join().toUpperCase();
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 7.h), child: Row(children: [Icon(icon, size: 15.sp, color: Colors.grey.shade600), SizedBox(width: 8.w), Expanded(child: TextApp(text: text, theme: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis))]));
}
