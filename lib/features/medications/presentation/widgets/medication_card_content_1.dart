part of 'medication_card.dart';

extension MedicationCardContent1 on MedicationCard {
  List<Widget> _buildMedicationCardContent1(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return [
            Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    color: primary,
                    size: 21.sp,
                  ),
                ),
                const Spacer(),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  onPressed: () {
                    showMedicationQrCodeBottomSheet(context, medication);
                  },
                  icon: Icon(Icons.qr_code_2, size: 19.sp),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 34.w, minHeight: 34.w),
                  onPressed: onEditPressed,
                  icon: Icon(Icons.edit_outlined, size: 19.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            TextApp(
              text: medication.name,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if ((medication.genericName ?? '').isNotEmpty) ...[
              SizedBox(height: 2.h),
              TextApp(
                text: medication.genericName!,
                theme: context.textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: 8.h),
    ];
  }
}
