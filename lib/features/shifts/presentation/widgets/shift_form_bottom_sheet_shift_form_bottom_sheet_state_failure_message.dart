part of 'shift_form_bottom_sheet.dart';

extension ShiftFormBottomSheetStateFailureMessage on _ShiftFormBottomSheetState {
String _failureMessage() {
    final state = context.read<ShiftsCubit>().state;

    if (state is! ShiftsLoaded) {
      return context.translate(LangKeys.couldNotSaveShift);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSaveShift);
    }

    return buildShiftErrorMessage(context, errorMessage);
  }
}
