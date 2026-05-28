part of 'inventory_form_bottom_sheet.dart';

extension InventoryFormBottomSheetStateBuildInventoryErrorMessage on _InventoryFormBottomSheetState {
String _buildInventoryErrorMessage(
    BuildContext context,
    String errorMessage,
  ) {
    switch (errorMessage) {
      case 'branch_not_found':
        return context.translate(LangKeys.branchNotFound);
      case 'inactive_branch':
        return context.translate(LangKeys.inactiveBranch);
      case 'medication_not_found':
        return context.translate(LangKeys.medicationNotFoundPlain);
      case 'inactive_medication':
        return context.translate(LangKeys.inactiveMedicationPlain);
      case 'duplicate_inventory_item':
        return context.translate(LangKeys.duplicateInventoryItem);
      case 'inventory_item_not_found':
        return context.translate(LangKeys.inventoryItemNotFound);
      case 'quantity_cannot_go_below_zero':
        return context.translate(LangKeys.quantityCannotGoBelowZero);
      case 'inventory_missing_medication':
        return context.translate(LangKeys.inventoryMissingMedication);
      case 'inventory_missing_branch':
        return context.translate(LangKeys.inventoryMissingBranch);
      case 'inventory_invalid_quantity':
        return context.translate(LangKeys.inventoryInvalidQuantity);
      case 'inventory_invalid_min_stock_level':
        return context.translate(LangKeys.inventoryInvalidMinStockLevel);
      case 'inventory_invalid_expiry_date':
        return context.translate(LangKeys.inventoryInvalidExpiryDate);
      default:
        return context.translate(LangKeys.couldNotSaveInventoryItem);
    }
  }
}
