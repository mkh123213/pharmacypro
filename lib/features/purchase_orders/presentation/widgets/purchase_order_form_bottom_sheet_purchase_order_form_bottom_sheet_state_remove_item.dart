part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateRemoveItem on _PurchaseOrderFormBottomSheetState {
void removeItem(int index) {
    if (!_canEdit) return;

    setState(() {
      items.removeAt(index);
    });
  }
}
