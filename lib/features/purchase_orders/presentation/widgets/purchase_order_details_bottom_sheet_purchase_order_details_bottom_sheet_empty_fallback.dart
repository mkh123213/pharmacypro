part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetEmptyFallback on _PurchaseOrderDetailsBottomSheet {
String _emptyFallback(String? value) {
    if (value == null || value.trim().isEmpty) return '-';
    return value;
  }
}
