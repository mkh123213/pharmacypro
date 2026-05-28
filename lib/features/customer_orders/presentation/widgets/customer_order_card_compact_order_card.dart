part of 'customer_order_card.dart';

class _CompactOrderCard extends StatelessWidget {
  const _CompactOrderCard({required this.order, required this.onNextStatus, this.onDelete});

  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OrderHeader(order: order),
        SizedBox(height: 10.h),
        _InfoRow(
          label: context.translate(LangKeys.branch),
          value: order.branchName ?? '-',
        ),
        _InfoRow(
          label: context.translate(LangKeys.orderType),
          value: customerOrderTypeLabel(context, order.orderType),
        ),
        _InfoRow(
          label: context.translate(LangKeys.items),
          value: _itemsText(order),
        ),
        _InfoRow(
          label: context.translate(LangKeys.total),
          value: '\$${order.totalAmount.toStringAsFixed(2)}',
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (onDelete != null)
              TextButton(
                onPressed: onDelete,
                child: TextApp(
                  text: context.translate(LangKeys.delete),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(color: Colors.red),
                ),
              ),
            if (onNextStatus != null)
              TextButton(
                onPressed: onNextStatus,
                child: TextApp(
                  text: context.translate(LangKeys.next),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
