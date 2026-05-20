part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateValidateSaleItems on _SaleFormBottomSheetState {
String? _validateSaleItems() {
    for (final item in items) {
      if (item.medicationId.trim().isEmpty) {
        return context.translate(LangKeys.saleItemMissingMedication);
      }

      if (item.quantity <= 0) {
        return context.translate(LangKeys.saleItemInvalidQuantity);
      }

      if (item.unitPrice < 0) {
        return context.translate(LangKeys.saleItemInvalidUnitPrice);
      }

      if (item.total < 0) {
        return context.translate(LangKeys.saleItemInvalidTotal);
      }
    }

    return null;
  }
}
