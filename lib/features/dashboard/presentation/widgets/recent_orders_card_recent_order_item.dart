part of 'recent_orders_card.dart';

class _RecentOrderItem extends StatelessWidget {
  const _RecentOrderItem({required this.order});

  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 320;

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OrderInfo(order: order),
              SizedBox(height: 8.h),
              _OrderAmountAndStatus(order: order),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _OrderInfo(order: order)),
            SizedBox(width: 10.w),
            _OrderAmountAndStatus(order: order),
          ],
        );
      },
    );
  }
}
