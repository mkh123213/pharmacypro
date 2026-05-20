import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/prescription_model.dart';
import '../refactor/prescriptions_constants.dart';

part 'prescription_details_bottom_sheet_detail_row.dart';

void showPrescriptionDetailsBottomSheet(
  BuildContext context,
  PrescriptionModel prescription,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.color.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextApp(
                  text: context.translate(LangKeys.prescriptionDetails),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                _DetailRow(
                  label: context.translate(LangKeys.prescriptionNumber),
                  value: prescription.prescriptionNumber ?? prescription.id,
                ),
                _DetailRow(
                  label: context.translate(LangKeys.patient),
                  value: prescription.patientName,
                ),
                _DetailRow(
                  label: context.translate(LangKeys.patientPhone),
                  value: prescription.patientPhone ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.doctor),
                  value: prescription.doctorName ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.doctorLicense),
                  value: prescription.doctorLicense ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.branch),
                  value: prescription.branchName ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.issueDate),
                  value: prescription.issueDate ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.expiryDate),
                  value: prescription.expiryDate ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.status),
                  value: prescriptionStatusLabel(context, prescription.status),
                ),
                if ((prescription.notes ?? '').trim().isNotEmpty)
                  _DetailRow(
                    label: context.translate(LangKeys.notes),
                    value: prescription.notes!,
                  ),
                SizedBox(height: 12.h),
                TextApp(
                  text: context.translate(LangKeys.prescriptionItems),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                if (prescription.items.isEmpty)
                  TextApp(
                    text: context.translate(LangKeys.noPrescriptionItems),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: prescription.items.length,
                    separatorBuilder: (_, _) => Divider(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = prescription.items[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: TextApp(
                          text: item.medicationName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle,
                        ),
                        subtitle: TextApp(
                          text:
                              '${context.translate(LangKeys.qty)}: ${item.quantity ?? 0}'
                              ' · ${item.dosage ?? context.translate(LangKeys.noDosage)}'
                              '${(item.instructions ?? '').isEmpty ? '' : '\n${item.instructions}'}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
