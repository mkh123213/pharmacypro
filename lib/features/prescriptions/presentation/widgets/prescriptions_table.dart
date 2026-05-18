import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/prescription_model.dart';
import '../refactor/prescriptions_constants.dart';

class PrescriptionsTable extends StatelessWidget {
  const PrescriptionsTable({
    required this.prescriptions,
    required this.onView,
    required this.onVerify,
    required this.onReject,
    required this.onDispense,
    this.isSubmitting = false,
    super.key,
  });

  final List<PrescriptionModel> prescriptions;
  final ValueChanged<PrescriptionModel> onView;
  final ValueChanged<PrescriptionModel> onVerify;
  final ValueChanged<PrescriptionModel> onReject;
  final ValueChanged<PrescriptionModel> onDispense;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.prescriptionNumber),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.patient),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.doctor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.branch),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.status),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.actions),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
          rows: prescriptions.map((prescription) {
            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text: prescription.prescriptionNumber ?? prescription.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: prescription.patientName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: prescription.doctorName ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: prescription.branchName ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: prescriptionStatusLabel(
                      context,
                      prescription.status,
                    ),
                    type: _statusType(prescription.status),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                onView(prescription);
                              },
                        icon: const Icon(Icons.visibility_outlined),
                      ),
                      if (prescription.status == 'pending')
                        IconButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onVerify(prescription);
                                },
                          icon: const Icon(Icons.check_circle_outline),
                        ),
                      if (prescription.status == 'pending')
                        IconButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onReject(prescription);
                                },
                          icon: const Icon(Icons.cancel_outlined),
                        ),
                      if (prescription.status == 'verified')
                        TextButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onDispense(prescription);
                                },
                          child: TextApp(
                            text: context.translate(LangKeys.dispense),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  AppStatusChipType _statusType(String status) {
    switch (status) {
      case 'pending':
        return AppStatusChipType.warning;
      case 'verified':
        return AppStatusChipType.info;
      case 'dispensed':
        return AppStatusChipType.success;
      case 'rejected':
        return AppStatusChipType.error;
      case 'expired':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}
