part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateRemoveItem on _CustomerOrderFormBottomSheetState {
void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
