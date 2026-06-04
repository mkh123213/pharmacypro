part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetNextActionLabel on _PurchaseOrderDetailsBottomSheet {
String _nextActionLabel(BuildContext context, String status) {
    final nextStatus = nextPurchaseOrderStatus[status];

    switch (nextStatus) {
      case 'sent':
        return context.translate(LangKeys.send);
      case 'confirmed':
        return context.translate(LangKeys.confirm);
      case 'received':
        return context.translate(LangKeys.receive);
      default:
        return context.translate(LangKeys.next);
    }
  }
}
