part of 'purchase_orders_table.dart';

extension PurchaseOrdersDataTableRows on _PurchaseOrdersDataTable {
  List<DataRow> _buildPurchaseOrdersDataTableRows(BuildContext context) {
    return orders.map((order) {
            final canEdit = order.status == 'draft';
            final canMoveNext = nextPurchaseOrderStatus.containsKey(
              order.status,
            );
            final canCancel =
                order.status != 'received' && order.status != 'cancelled';

            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text: order.orderNumber ?? order.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: order.supplierName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: order.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '\$${order.totalAmount.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: purchaseOrderStatusLabel(context, order.status),
                    type: _statusType(order.status),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: context.translate(LangKeys.view),
                        onPressed: isSubmitting
                            ? null
                            : () {
                                onView(order);
                              },
                        icon: const Icon(Icons.visibility_outlined),
                      ),
                      if (canEdit)
                        IconButton(
                          tooltip: context.translate(LangKeys.edit),
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onEdit(order);
                                },
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      if (canMoveNext)
                        TextButton(
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
                        TextButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onCancel(order);
                                },
                          child: TextApp(
                            text: context.translate(LangKeys.cancel),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList();
  }
}
