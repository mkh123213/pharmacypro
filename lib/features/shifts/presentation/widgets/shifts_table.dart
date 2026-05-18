import 'package:flutter/material.dart';
import 'package:pharmacypro/features/shifts/presentation/refactor/shifts_constants.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/shift_model.dart';

class ShiftsTable extends StatelessWidget {
  const ShiftsTable({required this.shifts, super.key});

  final List<ShiftModel> shifts;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.staff),
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
                text: context.translate(LangKeys.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.time),
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
          ],
          rows: shifts.map((shift) {
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
                    type: _statusType(shift.status),
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
      case 'scheduled':
        return AppStatusChipType.info;
      case 'in_progress':
        return AppStatusChipType.warning;
      case 'completed':
        return AppStatusChipType.success;
      case 'absent':
        return AppStatusChipType.error;
      case 'cancelled':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}
