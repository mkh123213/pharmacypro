import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/supplier_model.dart';

class SupplierCard extends StatelessWidget {
  const SupplierCard({
    required this.supplier,
    required this.onEditPressed,
    required this.onDeletePressed,
    super.key,
  });

  final SupplierModel supplier;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

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
                    Icons.local_shipping_outlined,
                    color: primary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextApp(
                    text: supplier.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontSize: 14.sp,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
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
                IconButton(
                  tooltip: context.translate(LangKeys.delete),
                  onPressed: onDeletePressed,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  icon: Icon(Icons.delete_outline, size: 19.sp, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            if ((supplier.contactPerson ?? '').trim().isNotEmpty)
              _Info(icon: Icons.person_outline, text: supplier.contactPerson!),
            if ((supplier.email ?? '').trim().isNotEmpty)
              _Info(icon: Icons.mail_outline, text: supplier.email!),
            if ((supplier.phone ?? '').trim().isNotEmpty)
              _Info(icon: Icons.phone_outlined, text: supplier.phone!),
            if ((supplier.address ?? '').trim().isNotEmpty)
              _Info(icon: Icons.location_on_outlined, text: supplier.address!),
            if ((supplier.notes ?? '').trim().isNotEmpty)
              _Info(icon: Icons.notes_outlined, text: supplier.notes!),
            SizedBox(height: 8.h),
            Row(
              children: [
                if ((supplier.paymentTerms ?? '').trim().isNotEmpty)
                  Expanded(
                    child: TextApp(
                      text: supplier.paymentTerms!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        fontSize: 12.sp,
                        color: context.color.textSecondary,
                        height: 1.1,
                      ),
                    ),
                  )
                else
                  const Spacer(),
                SizedBox(width: 8.w),
                AppStatusChip(
                  label: supplier.isActive
                      ? context.translate(LangKeys.active)
                      : context.translate(LangKeys.inactive),
                  type: supplier.isActive
                      ? AppStatusChipType.success
                      : AppStatusChipType.error,
                ),
              ],
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
