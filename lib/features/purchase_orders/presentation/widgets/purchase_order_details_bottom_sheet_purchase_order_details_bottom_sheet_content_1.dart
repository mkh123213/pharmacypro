part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetContent1 on _PurchaseOrderDetailsBottomSheet {
  List<Widget> _buildPurchaseOrderDetailsBottomSheetContent1(BuildContext context) {
    return [
              AppBottomSheetHeader(
                title: context
                    .translate(LangKeys.purchaseOrderTitle)
                    .replaceAll('{number}', order.orderNumber ?? order.id),
                trailing: AppStatusChip(
                  label: purchaseOrderStatusLabel(context, order.status),
                  type: this._statusType(order.status),
                ),
              ),
              SizedBox(height: 16.h),
    ];
  }
}
