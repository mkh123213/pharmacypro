part of 'purchase_order_details_bottom_sheet.dart';

extension PurchaseOrderDetailsBottomSheetContent4 on _PurchaseOrderDetailsBottomSheet {
  List<Widget> _buildPurchaseOrderDetailsBottomSheetContent4(BuildContext context) {
    return [
              if (_canEdit || _canMoveNext || _canCancel) ...[
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    if (_canEdit && onEdit != null)
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onEdit!(order);
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: TextApp(
                          text: context.translate(LangKeys.edit),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle,
                        ),
                      ),
                    if (_canMoveNext && onNextStatus != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onNextStatus!(order);
                        },
                        child: TextApp(
                          text: this._nextActionLabel(context, order.status),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle,
                        ),
                      ),
                    if (_canCancel && onCancel != null)
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel!(order);
                        },
                        child: TextApp(
                          text: context.translate(LangKeys.cancel),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle.copyWith(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ],
    ];
  }
}
