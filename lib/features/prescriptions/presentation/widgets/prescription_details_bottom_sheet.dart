import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/prescription_model.dart';
import '../refactor/prescriptions_constants.dart';

void showPrescriptionDetailsBottomSheet(
  BuildContext context,
  PrescriptionModel prescription,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextApp(
                  text: context.translate(LangKeys.prescriptionDetails),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 12.h),
                _DetailRow(
                  label: context.translate(LangKeys.patient),
                  value: prescription.patientName,
                ),
                _DetailRow(
                  label: context.translate(LangKeys.doctor),
                  value: prescription.doctorName ?? '—',
                ),
                _DetailRow(
                  label: context.translate(LangKeys.status),
                  value: prescriptionStatusLabel(context, prescription.status),
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
                  ...prescription.items.map((item) {
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
                  }),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextApp(
            text: '$label: ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: TextApp(
              text: value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
