part of 'shifts_body.dart';

extension ShiftsBodyUpdateShiftStatus on ShiftsBody {
Future<void> _updateShiftStatus({
    required BuildContext context,
    required ShiftModel shift,
    required String status,
  }) async {
    final success = await context.read<ShiftsCubit>().updateStatus(
      shift.id,
      status,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<ShiftsCubit>().state;

      String message = context.translate(LangKeys.couldNotUpdateShiftStatus);

      if (state is ShiftsLoaded && state.errorMessage != null) {
        message = buildShiftErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.shiftStatusUpdatedSuccessfully),
    );
  }
}
