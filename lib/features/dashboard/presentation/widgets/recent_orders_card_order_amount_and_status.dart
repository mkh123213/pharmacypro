part of 'recent_orders_card.dart';

class _OrderAmountAndStatus extends StatelessWidget {
  const _OrderAmountAndStatus({required this.order});

  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 130.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextApp(
            text: '\$${order.totalAmount.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: AppStatusChip(
              label: _orderStatusLabel(context, order.status),
              type: _statusType(order.status),
            ),
          ),
        ],
      ),
    );
  }

  String _orderStatusLabel(BuildContext context, String value) {
    switch (value) {
      case 'pending':
        return context.translate(LangKeys.pending);
      case 'confirmed':
        return context.translate(LangKeys.confirmed);
      case 'processing':
        return context.translate(LangKeys.processing);
      case 'ready':
        return context.translate(LangKeys.ready);
      case 'out_for_delivery':
        return context.translate(LangKeys.outForDelivery);
      case 'delivered':
        return context.translate(LangKeys.delivered);
      case 'cancelled':
        return context.translate(LangKeys.cancelled);
      default:
        return value;
    }
  }

  AppStatusChipType _statusType(String status) {
    switch (status) {
      case 'pending':
        return AppStatusChipType.warning;
      case 'confirmed':
        return AppStatusChipType.info;
      case 'processing':
        return AppStatusChipType.primary;
      case 'ready':
        return AppStatusChipType.success;
      case 'out_for_delivery':
        return AppStatusChipType.info;
      case 'delivered':
        return AppStatusChipType.success;
      case 'cancelled':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}
