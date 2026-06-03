part of 'inventory_alerts_table.dart';

extension InventoryAlertsTableColumns on InventoryAlertsTable {
  List<DataColumn> _buildInventoryAlertsTableColumns(BuildContext context) {
    return [
DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.alertType),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.medication),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.branch),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.quantity),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.minStockLevel),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.expiryDate),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.batchNumber),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.actions),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
    ];
  }
}
