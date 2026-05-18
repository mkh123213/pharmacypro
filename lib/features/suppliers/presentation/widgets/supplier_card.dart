import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/supplier_model.dart';

class SupplierCard extends StatelessWidget {
  const SupplierCard({
    required this.supplier,
    required this.onEditPressed,
    super.key,
  });

  final SupplierModel supplier;
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
                    Icons.local_shipping_outlined,
                    color: primary,
                    size: 20.sp,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onEditPressed,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  icon: Icon(Icons.edit_outlined, size: 19.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              supplier.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            if ((supplier.contactPerson ?? '').isNotEmpty)
              _Info(icon: Icons.person_outline, text: supplier.contactPerson!),
            if ((supplier.email ?? '').isNotEmpty)
              _Info(icon: Icons.mail_outline, text: supplier.email!),
            if ((supplier.phone ?? '').isNotEmpty)
              _Info(icon: Icons.phone_outlined, text: supplier.phone!),
            SizedBox(height: 8.h),
            Row(
              children: [
                if ((supplier.paymentTerms ?? '').isNotEmpty)
                  Expanded(
                    child: Text(
                      supplier.paymentTerms!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        height: 1.1,
                      ),
                    ),
                  )
                else
                  const Spacer(),
                SizedBox(width: 8.w),
                Chip(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                  label: Text(
                    supplier.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: supplier.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                  backgroundColor: supplier.isActive
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  side: BorderSide(
                    color: supplier.isActive
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                  ),
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
