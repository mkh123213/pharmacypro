part of 'customer_order_card.dart';

class _WideOrderCard extends StatelessWidget {
  const _WideOrderCard({required this.order, required this.onNextStatus, this.onDelete});

  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(child: Icon(Icons.shopping_bag_outlined, size: 20.sp)),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                text: order.customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              TextApp(
                text:
                    '${order.branchName ?? '-'} · ${customerOrderTypeLabel(context, order.orderType)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              SizedBox(height: 6.h),
              TextApp(
                text: _itemsText(order),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextApp(
              text: '\$${order.totalAmount.toStringAsFixed(2)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            TextApp(
              text: _dateText(order),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
            AppStatusChip(
              label: customerOrderStatusLabel(context, order.status),
              type: _statusType(order.status),
            ),
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
