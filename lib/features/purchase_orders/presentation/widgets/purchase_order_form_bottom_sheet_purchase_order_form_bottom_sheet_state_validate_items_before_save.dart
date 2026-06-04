part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateValidateItemsBeforeSave on _PurchaseOrderFormBottomSheetState {
String? _validateItemsBeforeSave() {
    double calculatedTotal = 0;

    for (final item in items) {
      if (item.medicationId.trim().isEmpty) {
        return context.translate(LangKeys.purchaseOrderItemMissingMedication);
      }

      if (item.quantity <= 0) {
        return context.translate(LangKeys.purchaseOrderItemInvalidQuantity);
      }

      if (item.unitCost <= 0) {
        return context.translate(LangKeys.purchaseOrderItemInvalidUnitCost);
      }

      final expectedItemTotal = item.quantity * item.unitCost;

      if (item.total <= 0 || (item.total - expectedItemTotal).abs() > 0.01) {
        return context.translate(LangKeys.purchaseOrderItemInvalidTotal);
      }

      calculatedTotal += item.total;
    }

    if (total <= 0 || (total - calculatedTotal).abs() > 0.01) {
      return context.translate(LangKeys.purchaseOrderInvalidTotal);
    }

    return null;
  }
}
