part of 'prescriptions_table.dart';

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({
    required this.prescription,
    required this.isSubmitting,
    required this.onView,
    required this.onVerify,
    required this.onReject,
    required this.onDispense,
  });

  final PrescriptionModel prescription;
  final bool isSubmitting;
  final ValueChanged<PrescriptionModel> onView;
  final ValueChanged<PrescriptionModel> onVerify;
  final ValueChanged<PrescriptionModel> onReject;
  final ValueChanged<PrescriptionModel> onDispense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextApp(
                    text: prescription.prescriptionNumber ?? prescription.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppStatusChip(
                  label: prescriptionStatusLabel(context, prescription.status),
                  type: _statusType(prescription.status),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            _InfoLine(
              label: context.translate(LangKeys.patient),
              value: prescription.patientName,
            ),
            _InfoLine(
              label: context.translate(LangKeys.doctor),
              value: prescription.doctorName ?? '—',
            ),
            _InfoLine(
              label: context.translate(LangKeys.branch),
              value: prescription.branchName ?? '—',
            ),
            SizedBox(height: 8.h),
            _PrescriptionActions(
              prescription: prescription,
              isSubmitting: isSubmitting,
              onView: onView,
              onVerify: onVerify,
              onReject: onReject,
              onDispense: onDispense,
            ),
          ],
        ),
      ),
    );
  }
}
