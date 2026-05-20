part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetContent3 on _PurchaseOrderDetailsBottomSheet {
  List<Widget> _buildPurchaseOrderDetailsBottomSheetContent3(BuildContext context) {
    return [
              if (order.items.isEmpty)
                TextApp(
                  text: context.translate(LangKeys.noItemsAdded),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                )
              else
                ...order.items.map((item) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp(
                            text: item.medicationName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _DetailsRow(
                            label: context.translate(LangKeys.quantity),
                            value: item.quantity.toString(),
                          ),
                          _DetailsRow(
                            label: context.translate(LangKeys.unitCost),
                            value: '\$${item.unitCost.toStringAsFixed(2)}',
                          ),
                          _DetailsRow(
                            label: context.translate(LangKeys.total),
                            value: '\$${item.total.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              if (order.notes != null && order.notes!.trim().isNotEmpty) ...[
                SizedBox(height: 8.h),
                TextApp(
                  text: context.translate(LangKeys.notes),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text: order.notes!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
              ],
    ];
  }
}
