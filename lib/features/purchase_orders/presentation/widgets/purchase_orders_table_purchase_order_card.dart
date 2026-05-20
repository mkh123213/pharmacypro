part of 'purchase_orders_table.dart';

class _PurchaseOrderCard extends StatelessWidget {
  const _PurchaseOrderCard({
    required this.order,
    required this.onView,
    required this.onEdit,
    required this.onNextStatus,
    required this.onCancel,
    required this.isSubmitting,
  });

  final PurchaseOrderModel order;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onEdit;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  final ValueChanged<PurchaseOrderModel> onCancel;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final canEdit = order.status == 'draft';
    final canMoveNext = nextPurchaseOrderStatus.containsKey(order.status);
    final canCancel = order.status != 'received' && order.status != 'cancelled';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextApp(
                    text: order.orderNumber ?? order.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                AppStatusChip(
                  label: purchaseOrderStatusLabel(context, order.status),
                  type: _statusType(order.status),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _InfoRow(
              label: context.translate(LangKeys.supplier),
              value: order.supplierName ?? '-',
            ),
            _InfoRow(
              label: context.translate(LangKeys.branch),
              value: order.branchName ?? '-',
            ),
            _InfoRow(
              label: context.translate(LangKeys.orderDate),
              value: _emptyFallback(order.orderDate),
            ),
            _InfoRow(
              label: context.translate(LangKeys.total),
              value: '\$${order.totalAmount.toStringAsFixed(2)}',
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                OutlinedButton.icon(
                  onPressed: isSubmitting
                      ? null
                      : () {
                          onView(order);
                        },
                  icon: const Icon(Icons.visibility_outlined),
                  label: TextApp(
                    text: context.translate(LangKeys.view),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                if (canEdit)
                  OutlinedButton.icon(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            onEdit(order);
                          },
                    icon: const Icon(Icons.edit_outlined),
                    label: TextApp(
                      text: context.translate(LangKeys.edit),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                if (canMoveNext)
                  OutlinedButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            onNextStatus(order);
                          },
                    child: TextApp(
                      text: _nextActionLabel(context, order.status),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                if (canCancel)
                  OutlinedButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            onCancel(order);
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
        ),
      ),
    );
  }
}
