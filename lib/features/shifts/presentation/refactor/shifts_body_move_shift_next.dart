part of 'shifts_body.dart';

extension ShiftsBodyMoveShiftNext on ShiftsBody {
Future<void> _moveShiftNext({
    required BuildContext context,
    required ShiftModel shift,
  }) async {
    final nextStatus = nextShiftStatus(shift.status);

    if (nextStatus == shift.status) return;

    await this._updateShiftStatus(
      context: context,
      shift: shift,
      status: nextStatus,
    );
  }
}
