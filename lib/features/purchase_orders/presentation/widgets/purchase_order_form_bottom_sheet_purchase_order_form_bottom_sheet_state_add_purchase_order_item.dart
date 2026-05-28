part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateAddPurchaseOrderItem on _PurchaseOrderFormBottomSheetState {
Future<void> addPurchaseOrderItem() async {
    if (!_canEdit) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.onlyDraftPurchaseOrdersCanBeEdited),
      );
      return;
    }

    if (widget.medications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    final result = await showPurchaseOrderItemFormBottomSheet(
      context: context,
      medications: widget.medications,
    );

    if (result == null) return;

    setState(() {
      final existingIndex = items.indexWhere(
        (item) => item.medicationId == result.medicationId,
      );

      if (existingIndex == -1) {
        items.add(result);
        return;
      }

      final existing = items[existingIndex];
      final newQuantity = existing.quantity + result.quantity;
      final newTotal = newQuantity * result.unitCost;

      items[existingIndex] = PurchaseOrderItemModel(
        medicationId: existing.medicationId,
        medicationName: existing.medicationName,
        quantity: newQuantity,
        unitCost: result.unitCost,
        total: newTotal,
      );
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToPurchaseOrder),
    );
  }
}
