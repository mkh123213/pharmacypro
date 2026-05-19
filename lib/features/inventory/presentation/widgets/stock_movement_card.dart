import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/stock_movement_model.dart';
import 'stock_movement_filter_bar.dart';

class StockMovementCard extends StatelessWidget {
  const StockMovementCard({required this.movement, super.key});

  final StockMovementModel movement;

  @override
  Widget build(BuildContext context) {
    final isIncrease = movement.quantityChange > 0;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextApp(
                    text: movement.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppStatusChip(
                  label: isIncrease
                      ? '+${movement.quantityChange}'
                      : '${movement.quantityChange}',
                  type: isIncrease
                      ? AppStatusChipType.success
                      : AppStatusChipType.error,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            TextApp(
              text: movement.branchName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 6.h),
            TextApp(
              text: stockMovementTypeLabel(context, movement.type),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 6.h),
            TextApp(
              text:
                  '${context.translate(LangKeys.quantityBefore)}: ${movement.quantityBefore}  →  ${context.translate(LangKeys.quantityAfter)}: ${movement.quantityAfter}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            if ((movement.reason ?? '').isNotEmpty) ...[
              SizedBox(height: 6.h),
              TextApp(
                text:
                    '${context.translate(LangKeys.reason)}: ${movement.reason}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
            if (movement.createdAt != null) ...[
              SizedBox(height: 6.h),
              TextApp(
                text: movement.createdAt!.toLocal().toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
