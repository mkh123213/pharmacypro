part of 'customer_order_card.dart';

class _CompactOrderCard extends StatelessWidget {
  const _CompactOrderCard({required this.order, required this.onNextStatus});

  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;

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
        if (onNextStatus != null)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: onNextStatus,
              child: TextApp(
                text: context.translate(LangKeys.next),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ),
      ],
    );
  }
}
