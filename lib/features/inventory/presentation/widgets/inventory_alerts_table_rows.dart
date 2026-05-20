part of 'inventory_alerts_table.dart';

extension InventoryAlertsTableRows on InventoryAlertsTable {
  List<DataRow> _buildInventoryAlertsTableRows(BuildContext context) {
    return alerts.map((alert) {
            final item = alert.inventoryItem;

            return DataRow(
              cells: [
                DataCell(
                  AppStatusChip(
                    label: inventoryAlertTypeLabel(context, alert.type),
                    type: _chipType(alert.type),
                  ),
                ),
                DataCell(
                  TextApp(
                    text: item.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: item.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '${item.quantity}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '${item.minStockLevel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: item.expiryDate ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: item.batchNumber ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  alert.type == 'expired'
                      ? TextButton.icon(
                          onPressed: () {
                            onRemoveExpiredStock(alert);
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: TextApp(
                            text: context.translate(
                              LangKeys.removeExpiredStock,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          }).toList();
  }
}
