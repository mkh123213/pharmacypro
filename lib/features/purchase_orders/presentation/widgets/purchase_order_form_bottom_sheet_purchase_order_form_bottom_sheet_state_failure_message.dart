part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateFailureMessage on _PurchaseOrderFormBottomSheetState {
String _failureMessage() {
    final state = context.read<PurchaseOrdersCubit>().state;

    if (state is! PurchaseOrdersLoaded) {
      return context.translate(LangKeys.couldNotSavePurchaseOrder);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSavePurchaseOrder);
    }

    return buildPurchaseOrderErrorMessage(context, errorMessage);
  }
}
