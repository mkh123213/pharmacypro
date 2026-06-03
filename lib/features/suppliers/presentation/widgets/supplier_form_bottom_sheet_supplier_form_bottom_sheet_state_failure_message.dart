part of 'supplier_form_bottom_sheet.dart';

extension SupplierFormBottomSheetStateFailureMessage on _SupplierFormBottomSheetState {
String _failureMessage() {
    final state = context.read<SuppliersCubit>().state;

    if (state is! SuppliersLoaded) {
      return context.translate(LangKeys.couldNotSaveSupplier);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSaveSupplier);
    }

    return buildSupplierErrorMessage(context, errorMessage);
  }
}
