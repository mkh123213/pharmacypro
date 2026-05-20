import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/inventory_alert_model.dart';
import 'inventory_alert_filter_bar.dart';

part 'inventory_alerts_table_columns.dart';
part 'inventory_alerts_table_rows.dart';

class InventoryAlertsTable extends StatelessWidget {
  const InventoryAlertsTable({
    required this.alerts,
    required this.onRemoveExpiredStock,
    super.key,
  });

  final List<InventoryAlertModel> alerts;
  final ValueChanged<InventoryAlertModel> onRemoveExpiredStock;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: this._buildInventoryAlertsTableColumns(context),
          rows: this._buildInventoryAlertsTableRows(context),
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
