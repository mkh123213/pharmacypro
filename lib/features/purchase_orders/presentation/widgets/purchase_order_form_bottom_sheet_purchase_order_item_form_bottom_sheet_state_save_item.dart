part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderItemFormBottomSheetStateSaveItem on _PurchaseOrderItemFormBottomSheetState {
void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    final medication = _selectedMedication;

    if (medication == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedication),
      );
      return;
    }

    final parsedQuantity = int.tryParse(quantity.text.trim()) ?? 1;
    final parsedUnitCost = double.tryParse(unitCost.text.trim()) ?? 0;
    final total = parsedQuantity * parsedUnitCost;

    if (parsedQuantity <= 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.purchaseOrderItemInvalidQuantity),
      );
      return;
    }

    if (parsedUnitCost <= 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.purchaseOrderItemInvalidUnitCost),
      );
      return;
    }

    if (total <= 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.purchaseOrderItemInvalidTotal),
      );
      return;
    }

    final item = PurchaseOrderItemModel(
      medicationId: medication.id,
      medicationName: medication.name,
      quantity: parsedQuantity,
      unitCost: parsedUnitCost,
      total: total,
    );

    Navigator.pop(context, item);
  }
}
