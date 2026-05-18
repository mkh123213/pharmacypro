import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../inventory/data/models/inventory_model.dart';

class LowStockItemsCard extends StatelessWidget {
  const LowStockItemsCard({required this.items, super.key});

  final List<InventoryModel> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              text: context.translate(LangKeys.lowStockItems),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            if (items.isEmpty)
              TextApp(
                text: context.translate(LangKeys.allStockLevelsAreHealthy),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              )
            else
              ...items.take(5).map((item) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: TextApp(
                    text: item.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  subtitle: TextApp(
                    text: item.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                  trailing: AppStatusChip(
                    label: context
                        .translate(LangKeys.quantityLeft)
                        .replaceAll('{quantity}', item.quantity.toString()),
                    type: AppStatusChipType.error,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
