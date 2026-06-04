part of 'inventory_adjust_stock_bottom_sheet.dart';

extension InventoryAdjustStockBottomSheetStateBuildErrorMessage on _InventoryAdjustStockBottomSheetState {
String _buildErrorMessage(BuildContext context, String errorMessage) {
    switch (errorMessage) {
      case 'inventory_item_not_found':
        return context.translate(LangKeys.inventoryItemNotFound);
      case 'quantity_cannot_go_below_zero':
        return context.translate(LangKeys.quantityCannotGoBelowZero);
      default:
        return context.translate(LangKeys.couldNotAdjustStock);
    }
  }
}
