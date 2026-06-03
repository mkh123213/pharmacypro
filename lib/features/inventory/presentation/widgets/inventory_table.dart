import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/inventory_model.dart';

part 'inventory_table_info_row.dart';
part 'inventory_table_inventory_cards.dart';
part 'inventory_table_inventory_data_table.dart';
part 'inventory_table_inventory_status_chip.dart';

part 'inventory_table_inventory_data_table_columns.dart';
part 'inventory_table_inventory_data_table_rows.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({
    required this.items,
    required this.onTap,
    required this.onAdjustStock,
    this.isSubmitting = false,
    this.onDelete,
    super.key,
  });

  final List<InventoryModel> items;
  final ValueChanged<InventoryModel> onTap;
  final ValueChanged<InventoryModel> onAdjustStock;
  final bool isSubmitting;
  final ValueChanged<InventoryModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return _InventoryCards(
            items: items,
            isSubmitting: isSubmitting,
            onTap: onTap,
            onAdjustStock: onAdjustStock,
            onDelete: onDelete,
          );
        }

        return _InventoryDataTable(
          items: items,
          isSubmitting: isSubmitting,
          onTap: onTap,
          onAdjustStock: onAdjustStock,
          onDelete: onDelete,
        );
      },
    );
  }
}
