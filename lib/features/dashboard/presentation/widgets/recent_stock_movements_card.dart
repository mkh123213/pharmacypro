import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../inventory/data/models/stock_movement_model.dart';

class RecentStockMovementsCard extends StatelessWidget {
  const RecentStockMovementsCard({required this.movements, super.key});

  final List<StockMovementModel> movements;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              text: context.translate(LangKeys.recentStockMovements),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            if (movements.isEmpty)
              TextApp(
                text: context.translate(LangKeys.noStockMovementsFound),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              )
            else
              ...movements.map((movement) {
                final isIncrease = movement.quantityChange > 0;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: TextApp(
                    text: movement.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  subtitle: TextApp(
                    text:
                        '${movement.branchName ?? ''} · ${_movementTypeLabel(context, movement.type)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  trailing: AppStatusChip(
                    label: isIncrease
                        ? '+${movement.quantityChange}'
                        : '${movement.quantityChange}',
                    type: isIncrease
                        ? AppStatusChipType.success
                        : AppStatusChipType.error,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  String _movementTypeLabel(BuildContext context, String value) {
    switch (value) {
      case 'sale':
        return context.translate(LangKeys.sale);
      case 'purchase_received':
        return context.translate(LangKeys.purchaseReceived);
      case 'customer_order_delivered':
        return context.translate(LangKeys.customerOrderDelivered);
      case 'prescription_dispensed':
        return context.translate(LangKeys.prescriptionDispensed);
      case 'manual_adjustment':
        return context.translate(LangKeys.manualAdjustment);
      default:
        return value;
    }
  }
}
