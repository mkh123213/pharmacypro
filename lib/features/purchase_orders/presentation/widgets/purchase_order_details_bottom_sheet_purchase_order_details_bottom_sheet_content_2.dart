part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetContent2 on _PurchaseOrderDetailsBottomSheet {
  List<Widget> _buildPurchaseOrderDetailsBottomSheetContent2(BuildContext context) {
    return [
              _DetailsSection(
                children: [
                  _DetailsRow(
                    label: context.translate(LangKeys.supplier),
                    value: order.supplierName ?? '-',
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.branch),
                    value: order.branchName ?? '-',
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.orderDate),
                    value: this._emptyFallback(order.orderDate),
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.expectedDelivery),
                    value: this._emptyFallback(order.expectedDelivery),
                  ),
                  if (order.createdAt != null)
                    _DetailsRow(
                      label: context.translate(LangKeys.createdAt),
                      value: this._formatDateTime(order.createdAt!),
                    ),
                  if (order.updatedAt != null)
                    _DetailsRow(
                      label: context.translate(LangKeys.updatedAt),
                      value: this._formatDateTime(order.updatedAt!),
                    ),
                  if (order.receivedAt != null)
                    _DetailsRow(
                      label: context.translate(LangKeys.receivedAt),
                      value: this._formatDateTime(order.receivedAt!),
                    ),
                  _DetailsRow(
                    label: context.translate(LangKeys.total),
                    value: '\$${order.totalAmount.toStringAsFixed(2)}',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              TextApp(
                text: context.translate(LangKeys.items),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
    ];
  }
}
