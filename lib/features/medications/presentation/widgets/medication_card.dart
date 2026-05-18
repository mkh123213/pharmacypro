import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/medication_model.dart';
import '../refactor/medications_constants.dart';
import 'medication_qr_code_bottom_sheet.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    required this.medication,
    required this.onEditPressed,
    super.key,
  });

  final MedicationModel medication;
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
              theme: context.textStyle,
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
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                if ((medication.category ?? '').isNotEmpty)
                  AppStatusChip(
                    label: medicationCategoryLabel(
                      context,
                      medication.category!,
                    ),
                    type: AppStatusChipType.info,
                  ),
                if ((medication.dosageForm ?? '').isNotEmpty)
                  AppStatusChip(
                    label: medicationFormLabel(context, medication.dosageForm!),
                    type: AppStatusChipType.neutral,
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextApp(
                        text: '\$${medication.price.toStringAsFixed(2)}',
                        theme: context.textStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((medication.strength ?? '').isNotEmpty)
                        TextApp(
                          text: medication.strength!,
                          theme: context.textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                if (medication.requiresPrescription)
                  AppStatusChip(
                    label: context.translate(LangKeys.rx),
                    type: AppStatusChipType.error,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
