import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../customer_orders/data/models/customer_order_model.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({required this.orders, super.key});

  final List<CustomerOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              text: context.translate(LangKeys.recentCustomerOrders),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            if (orders.isEmpty)
              TextApp(
                text: context.translate(LangKeys.noOrdersYet),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              )
            else
              ...orders.take(5).map((order) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: TextApp(
                    text: order.customerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  subtitle: TextApp(
                    text:
                        '${order.branchName ?? ''} · ${_orderTypeLabel(context, order.orderType)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextApp(
                        text: '\$${order.totalAmount.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      AppStatusChip(
                        label: _orderStatusLabel(context, order.status),
                        type: _statusType(order.status),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
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
