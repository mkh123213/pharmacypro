import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../customer_orders/data/models/customer_order_model.dart';

part 'recent_orders_card_order_amount_and_status.dart';
part 'recent_orders_card_order_info.dart';
part 'recent_orders_card_recent_order_item.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({required this.orders, super.key});

  final List<CustomerOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    final recentOrders = orders.take(5).toList();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextApp(
              text: context.translate(LangKeys.recentCustomerOrders),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.h),
            if (recentOrders.isEmpty)
              TextApp(
                text: context.translate(LangKeys.noOrdersYet),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              )
            else
              ListView.separated(
                itemCount: recentOrders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, _) => Divider(height: 12.h),
                itemBuilder: (context, index) {
                  return _RecentOrderItem(order: recentOrders[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}
