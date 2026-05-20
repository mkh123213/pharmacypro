part of 'inventory_table.dart';

extension InventoryDataTableRows on _InventoryDataTable {
  List<DataRow> _buildInventoryDataTableRows(BuildContext context) {
    return items.map((item) {
            return DataRow(
              onSelectChanged: isSubmitting
                  ? null
                  : (_) {
                      onTap(item);
                    },
              cells: [
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
                    theme: context.textStyle.copyWith(
                      color: item.isLowStock ? Colors.red : null,
                      fontWeight: FontWeight.w700,
                    ),
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
                    theme: context.textStyle.copyWith(
                      color: item.isExpired || item.isExpiringSoon
                          ? Colors.red
                          : null,
                    ),
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
                DataCell(_InventoryStatusChip(item: item)),
                DataCell(
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            onAdjustStock(item);
                          },
                    child: TextApp(
                      text: context.translate(LangKeys.adjustStock),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ),
              ],
            );
          }).toList();
  }
}
