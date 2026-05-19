import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/inventory_alert_model.dart';
import 'inventory_alert_filter_bar.dart';

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
          columns: [
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
          ],
          rows: alerts.map((alert) {
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
          }).toList(),
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
