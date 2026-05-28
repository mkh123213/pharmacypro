part of 'remove_expired_stock_bottom_sheet.dart';

extension RemoveExpiredStockBottomSheetStateBuildErrorMessage on _RemoveExpiredStockBottomSheetState {
String _buildErrorMessage(BuildContext context, String errorMessage) {
    switch (errorMessage) {
      case 'inventory_item_not_found':
        return context.translate(LangKeys.inventoryItemNotFound);
      case 'expired_stock_quantity_already_zero':
        return context.translate(LangKeys.expiredStockQuantityAlreadyZero);
      default:
        return context.translate(LangKeys.couldNotRemoveExpiredStock);
    }
  }
}
