part of 'branch_form_bottom_sheet.dart';

extension BranchFormBottomSheetStateFailureMessage on _BranchFormBottomSheetState {
String _failureMessage() {
    final state = context.read<BranchesCubit>().state;

    if (state is! BranchesLoaded) {
      return context.translate(LangKeys.couldNotSaveBranch);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSaveBranch);
    }

    return buildBranchErrorMessage(context, errorMessage);
  }
}
