part of 'prescriptions_table.dart';

extension PrescriptionsTableRows on PrescriptionsTable {
  List<DataRow> _buildPrescriptionsTableRows(BuildContext context) {
    return prescriptions.map((prescription) {
                return DataRow(
                  cells: [
                    DataCell(
                      TextApp(
                        text:
                            prescription.prescriptionNumber ?? prescription.id,
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
                      _PrescriptionActions(
                        prescription: prescription,
                        isSubmitting: isSubmitting,
                        onView: onView,
                        onVerify: onVerify,
                        onReject: onReject,
                        onDispense: onDispense,
                      ),
                    ),
                  ],
                );
              }).toList();
  }
}
