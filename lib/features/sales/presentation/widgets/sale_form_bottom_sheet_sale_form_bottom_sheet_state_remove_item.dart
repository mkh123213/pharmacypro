part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateRemoveItem on _SaleFormBottomSheetState {
void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
