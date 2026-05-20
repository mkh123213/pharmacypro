part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetContent1 on _PurchaseOrderDetailsBottomSheet {
  List<Widget> _buildPurchaseOrderDetailsBottomSheetContent1(BuildContext context) {
    return [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: context.color.border,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextApp(
                      text: context
                          .translate(LangKeys.purchaseOrderTitle)
                          .replaceAll(
                            '{number}',
                            order.orderNumber ?? order.id,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AppStatusChip(
                    label: purchaseOrderStatusLabel(context, order.status),
                    type: this._statusType(order.status),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
    ];
  }
}
