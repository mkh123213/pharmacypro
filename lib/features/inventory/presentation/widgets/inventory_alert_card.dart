import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/inventory_alert_model.dart';
import 'inventory_alert_filter_bar.dart';

class InventoryAlertCard extends StatelessWidget {
  const InventoryAlertCard({required this.alert, super.key});

  final InventoryAlertModel alert;

  @override
  Widget build(BuildContext context) {
    final item = alert.inventoryItem;

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
                    text: item.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppStatusChip(
                  label: inventoryAlertTypeLabel(context, alert.type),
                  type: _chipType(alert.type),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            TextApp(
              text:
                  '${context.translate(LangKeys.branch)}: ${item.branchName ?? '—'}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 6.h),
            if (alert.type == 'low_stock')
              TextApp(
                text:
                    '${context.translate(LangKeys.currentQuantity)}: ${item.quantity} · ${context.translate(LangKeys.minStockLevel)}: ${item.minStockLevel}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              )
            else
              TextApp(
                text:
                    '${context.translate(LangKeys.expiryDate)}: ${item.expiryDate ?? '—'}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            if ((item.batchNumber ?? '').isNotEmpty) ...[
              SizedBox(height: 6.h),
              TextApp(
                text:
                    '${context.translate(LangKeys.batchNumber)}: ${item.batchNumber}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
            if ((item.locationInStore ?? '').isNotEmpty) ...[
              SizedBox(height: 6.h),
              TextApp(
                text:
                    '${context.translate(LangKeys.locationInStore)}: ${item.locationInStore}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  AppStatusChipType _chipType(String type) {
    switch (type) {
      case 'expired':
        return AppStatusChipType.error;
      case 'expiring_soon':
        return AppStatusChipType.warning;
      case 'low_stock':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}
