import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/medications/data/models/medication_model.dart';
import '../../extensions/context_extension.dart';
import 'text_app.dart';

class SaleMedicationPickerTile extends StatelessWidget {
  const SaleMedicationPickerTile({
    required this.medication,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final MedicationModel medication;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final primary = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: isSelected ? primary : colors.border),
          color: isSelected ? primary.withOpacity(.06) : colors.surface,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: colors.primary.withOpacity(0.10),
              child: Icon(
                Icons.medication_outlined,
                color: colors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(child: _MedicationText(medication: medication)),
            SizedBox(width: 8.w),
            TextApp(
              text: '\$${medication.price.toStringAsFixed(2)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicationText extends StatelessWidget {
  const _MedicationText({required this.medication});

  final MedicationModel medication;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
          text: medication.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle,
        ),
        if ((medication.genericName ?? '').isNotEmpty)
          TextApp(
            text: medication.genericName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(color: context.color.textSecondary),
          ),
      ],
    );
  }
}
