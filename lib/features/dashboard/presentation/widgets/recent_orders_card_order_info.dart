part of 'recent_orders_card.dart';

class _OrderInfo extends StatelessWidget {
  const _OrderInfo({required this.order});

  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextApp(
          text: order.customerName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4.h),
        TextApp(
          text:
              '${order.branchName ?? '-'} · ${_orderTypeLabel(context, order.orderType)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(
            color: context.color.textSecondary,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  String _orderTypeLabel(BuildContext context, String value) {
    switch (value) {
      case 'pickup':
        return context.translate(LangKeys.pickup);
      case 'delivery':
        return context.translate(LangKeys.delivery);
      default:
        return value;
    }
  }
}
