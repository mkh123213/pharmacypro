import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/medication_model.dart';
import '../refactor/medications_constants.dart';
import 'medication_qr_code_bottom_sheet.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({required this.medication, required this.onEditPressed, super.key});

  final MedicationModel medication;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 40.w, height: 40.w, decoration: BoxDecoration(color: primary.withOpacity(.1), borderRadius: BorderRadius.circular(12.r)), child: Icon(Icons.medication_outlined, color: primary)),
            const Spacer(),
            IconButton(onPressed: () => showMedicationQrCodeBottomSheet(context, medication), icon: Icon(Icons.qr_code_2, size: 20.sp)),
            IconButton(onPressed: onEditPressed, icon: Icon(Icons.edit_outlined, size: 20.sp)),
          ]),
          SizedBox(height: 10.h),
          TextApp(text: medication.name, theme: Theme.of(context).textTheme.titleSmall, maxLines: 2, overflow: TextOverflow.ellipsis),
          if ((medication.genericName ?? '').isNotEmpty) TextApp(text: medication.genericName!, theme: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          SizedBox(height: 10.h),
          Wrap(spacing: 6.w, runSpacing: 6.h, children: [
            if ((medication.category ?? '').isNotEmpty) AppStatusChip(label: formatMedicationLabel(medication.category!), type: AppStatusChipType.info),
            if ((medication.dosageForm ?? '').isNotEmpty) AppStatusChip(label: formatMedicationLabel(medication.dosageForm!), type: AppStatusChipType.neutral),
          ]),
          const Spacer(),
          Divider(height: 22.h),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextApp(text: '\$${medication.price.toStringAsFixed(2)}', theme: Theme.of(context).textTheme.titleMedium),
              if ((medication.strength ?? '').isNotEmpty) TextApp(text: medication.strength!, theme: Theme.of(context).textTheme.bodySmall),
            ])),
            if (medication.requiresPrescription) const AppStatusChip(label: 'Rx', type: AppStatusChipType.error),
          ]),
        ]),
      ),
    );
  }
}
