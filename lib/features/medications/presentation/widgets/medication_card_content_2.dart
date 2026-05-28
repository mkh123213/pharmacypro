part of 'medication_card.dart';

extension MedicationCardContent2 on MedicationCard {
  List<Widget> _buildMedicationCardContent2(BuildContext context) {
    return [
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
                AppStatusChip(
                  label: medication.isActive
                      ? context.translate(LangKeys.active)
                      : context.translate(LangKeys.inactive),
                  type: medication.isActive
                      ? AppStatusChipType.success
                      : AppStatusChipType.error,
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
                        theme: context.textStyle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
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
    ];
  }
}
