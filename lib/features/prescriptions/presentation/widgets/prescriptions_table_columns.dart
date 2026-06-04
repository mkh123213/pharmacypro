part of 'prescriptions_table.dart';

extension PrescriptionsTableColumns on PrescriptionsTable {
  List<DataColumn> _buildPrescriptionsTableColumns(BuildContext context) {
    return [
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
    ];
  }
}
