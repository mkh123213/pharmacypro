part of 'shifts_table.dart';

extension ShiftsTableRows on ShiftsTable {
  List<DataRow> _buildShiftsTableRows(BuildContext context) {
    return shifts.map((shift) {
                return DataRow(
                  cells: [
                    DataCell(
                      TextApp(
                        text: shift.staffName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    DataCell(
                      TextApp(
                        text: shift.branchName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    DataCell(
                      TextApp(
                        text: shift.date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    DataCell(
                      TextApp(
                        text: '${shift.startTime} - ${shift.endTime}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    DataCell(
                      AppStatusChip(
                        label: shiftStatusLabel(context, shift.status),
                        type: shiftStatusType(shift.status),
                      ),
                    ),
                    DataCell(
                      _ShiftActions(
                        shift: shift,
                        isSubmitting: isSubmitting,
                        onNextStatus: onNextStatus,
                        onCancel: onCancel,
                      ),
                    ),
                  ],
                );
              }).toList();
  }
}
