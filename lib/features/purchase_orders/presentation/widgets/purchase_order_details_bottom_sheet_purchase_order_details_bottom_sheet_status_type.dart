part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetStatusType on _PurchaseOrderDetailsBottomSheet {
AppStatusChipType _statusType(String status) {
    switch (status) {
      case 'draft':
        return AppStatusChipType.neutral;
      case 'sent':
        return AppStatusChipType.info;
      case 'confirmed':
        return AppStatusChipType.warning;
      case 'received':
        return AppStatusChipType.success;
      case 'cancelled':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}
