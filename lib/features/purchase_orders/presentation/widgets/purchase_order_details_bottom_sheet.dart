import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/purchase_order_model.dart';

void showPurchaseOrderDetailsBottomSheet(
  BuildContext context,
  PurchaseOrderModel order,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextApp(
                text: context
                    .translate(LangKeys.purchaseOrderTitle)
                    .replaceAll('{number}', order.orderNumber ?? order.id),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              SizedBox(height: 12.h),
              if (order.items.isEmpty)
                TextApp(
                  text: context.translate(LangKeys.noItemsAdded),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                )
              else
                ...order.items.map((item) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: TextApp(
                      text: item.medicationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                    subtitle: TextApp(
                      text: context
                          .translate(LangKeys.qtyValue)
                          .replaceAll('{qty}', item.quantity.toString()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                    trailing: TextApp(
                      text: '\$${item.total.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  );
                }),
            ],
          ),
        ),
      );
    },
  );
}
