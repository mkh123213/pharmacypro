part of 'shifts_table.dart';

class _ShiftActions extends StatelessWidget {
  const _ShiftActions({
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
    final canMoveNext = canMoveShiftNext(shift.status);
    final canCancel = canCancelShift(shift.status);

    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        if (canMoveNext)
          TextButton(
            onPressed: isSubmitting
                ? null
                : () {
                    onNextStatus(shift);
                  },
            child: TextApp(
              text: _nextActionLabel(context, shift.status),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        if (canCancel)
          TextButton(
            onPressed: isSubmitting
                ? null
                : () {
                    onCancel(shift);
                  },
            child: TextApp(
              text: context.translate(LangKeys.cancel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }

  String _nextActionLabel(BuildContext context, String status) {
    final nextStatus = nextShiftStatus(status);

    switch (nextStatus) {
      case 'in_progress':
        return context.translate(LangKeys.startShift);
      case 'completed':
        return context.translate(LangKeys.completeShift);
      default:
        return context.translate(LangKeys.next);
    }
  }
}
