part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateValidateItems on _CustomerOrderFormBottomSheetState {
String? _validateItems() {
    for (final item in items) {
      if (item.medicationId.trim().isEmpty) {
        return context.translate(LangKeys.customerOrderItemMissingMedication);
      }

      if (item.quantity <= 0) {
        return context.translate(LangKeys.customerOrderItemInvalidQuantity);
      }

      if (item.unitPrice < 0) {
        return context.translate(LangKeys.customerOrderItemInvalidUnitPrice);
      }

      if (item.total < 0) {
        return context.translate(LangKeys.customerOrderItemInvalidTotal);
      }
    }

    return null;
  }
}
