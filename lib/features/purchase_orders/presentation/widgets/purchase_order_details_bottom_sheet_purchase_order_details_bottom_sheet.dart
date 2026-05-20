part of 'purchase_order_details_bottom_sheet.dart';

class _PurchaseOrderDetailsBottomSheet extends StatelessWidget {
  const _PurchaseOrderDetailsBottomSheet({
    required this.order,
    this.onEdit,
    this.onNextStatus,
    this.onCancel,
  });

  final PurchaseOrderModel order;
  final ValueChanged<PurchaseOrderModel>? onEdit;
  final ValueChanged<PurchaseOrderModel>? onNextStatus;
  final ValueChanged<PurchaseOrderModel>? onCancel;

  bool get _canEdit {
    return order.status == 'draft';
  }

  bool get _canMoveNext {
    return nextPurchaseOrderStatus.containsKey(order.status);
  }

  bool get _canCancel {
    return order.status != 'received' && order.status != 'cancelled';
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ...this._buildPurchaseOrderDetailsBottomSheetContent1(context),
            ...this._buildPurchaseOrderDetailsBottomSheetContent2(context),
            ...this._buildPurchaseOrderDetailsBottomSheetContent3(context),
            ...this._buildPurchaseOrderDetailsBottomSheetContent4(context),
          ],
          ),
        ),
      ),
    );
  }




}
