part of 'shifts_table.dart';

extension ShiftsTableColumns on ShiftsTable {
  List<DataColumn> _buildShiftsTableColumns(BuildContext context) {
    return [
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
