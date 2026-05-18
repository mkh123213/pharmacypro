import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/customer_order_model.dart';
import '../refactor/customer_orders_constants.dart';

class CustomerOrderCard extends StatelessWidget {
  const CustomerOrderCard({
    required this.order,
    required this.onNextStatus,
    super.key,
  });

  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
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
                    theme: context.textStyle,
                  ),
                  SizedBox(height: 4.h),
                  TextApp(
                    text:
                        '${order.branchName ?? ''} · ${customerOrderTypeLabel(context, order.orderType)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  SizedBox(height: 6.h),
                  TextApp(
                    text: order.items
                        .map(
                          (item) => '${item.medicationName} x${item.quantity}',
                        )
                        .join(', '),
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
                  theme: context.textStyle,
                ),
                TextApp(
                  text: order.createdAt == null
                      ? ''
                      : DateFormat('MMM d').format(order.createdAt!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 4.h),
                AppStatusChip(
                  label: customerOrderStatusLabel(context, order.status),
                  type: _statusType(order.status),
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
        ),
      ),
    );
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
