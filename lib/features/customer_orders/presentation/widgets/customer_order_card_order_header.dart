part of 'customer_order_card.dart';

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({required this.order});

  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Icon(Icons.shopping_bag_outlined, size: 20.sp)),
        SizedBox(width: 10.w),
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
              TextApp(
                text: _dateText(order),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        AppStatusChip(
          label: customerOrderStatusLabel(context, order.status),
          type: _statusType(order.status),
        ),
      ],
    );
  }
}
