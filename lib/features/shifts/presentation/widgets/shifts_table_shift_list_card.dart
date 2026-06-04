part of 'shifts_table.dart';

class _ShiftListCard extends StatelessWidget {
  const _ShiftListCard({
    required this.shift,
    required this.isSubmitting,
    required this.onNextStatus,
    required this.onCancel,
  });

  final ShiftModel shift;
  final bool isSubmitting;
  final ValueChanged<ShiftModel> onNextStatus;
  final ValueChanged<ShiftModel> onCancel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextApp(
                    text: shift.staffName ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppStatusChip(
                  label: shiftStatusLabel(context, shift.status),
                  type: shiftStatusType(shift.status),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            _InfoRow(
              label: context.translate(LangKeys.branch),
              value: shift.branchName ?? '-',
            ),
            _InfoRow(
              label: context.translate(LangKeys.date),
              value: shift.date,
            ),
            _InfoRow(
              label: context.translate(LangKeys.time),
              value: '${shift.startTime} - ${shift.endTime}',
            ),
            if ((shift.notes ?? '').trim().isNotEmpty)
              _InfoRow(
                label: context.translate(LangKeys.notes),
                value: shift.notes!,
              ),
            SizedBox(height: 8.h),
            _ShiftActions(
              shift: shift,
              isSubmitting: isSubmitting,
              onNextStatus: onNextStatus,
              onCancel: onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
