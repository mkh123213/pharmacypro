part of 'shifts_body.dart';

extension ShiftsBodyConfirmCancelShift on ShiftsBody {
Future<void> _confirmCancelShift(
    BuildContext context,
    ShiftModel shift,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: TextApp(
            text: context.translate(LangKeys.cancelShift),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          content: TextApp(
            text: context.translate(LangKeys.cancelShiftConfirmation),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: TextApp(
                text: context.translate(LangKeys.no),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: TextApp(
                text: context.translate(LangKeys.yesCancel),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await this._updateShiftStatus(
      context: context,
      shift: shift,
      status: 'cancelled',
    );
  }
}
