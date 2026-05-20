import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/shift_model.dart';
import '../refactor/shifts_constants.dart';

part 'shifts_table_info_row.dart';
part 'shifts_table_shift_actions.dart';
part 'shifts_table_shift_list_card.dart';

part 'shifts_table_columns.dart';
part 'shifts_table_rows.dart';

class ShiftsTable extends StatelessWidget {
  const ShiftsTable({
    required this.shifts,
    required this.onNextStatus,
    required this.onCancel,
    this.isSubmitting = false,
    super.key,
  });

  final List<ShiftModel> shifts;
  final ValueChanged<ShiftModel> onNextStatus;
  final ValueChanged<ShiftModel> onCancel;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 720;

        if (compact) {
          return ListView.separated(
            itemCount: shifts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final shift = shifts[index];

              return _ShiftListCard(
                shift: shift,
                isSubmitting: isSubmitting,
                onNextStatus: onNextStatus,
                onCancel: onCancel,
              );
            },
          );
        }

        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: this._buildShiftsTableColumns(context),
              rows: this._buildShiftsTableRows(context),
            ),
          ),
        );
      },
    );
  }
}
