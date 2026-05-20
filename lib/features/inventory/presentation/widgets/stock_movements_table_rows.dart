part of 'stock_movements_table.dart';

extension StockMovementsTableRows on StockMovementsTable {
  List<DataRow> _buildStockMovementsTableRows(BuildContext context) {
    return movements.map((movement) {
            final isIncrease = movement.quantityChange > 0;

            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text: movement.createdAt?.toLocal().toString() ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: movement.medicationName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: movement.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: stockMovementTypeLabel(context, movement.type),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: isIncrease
                        ? '+${movement.quantityChange}'
                        : '${movement.quantityChange}',
                    type: isIncrease
                        ? AppStatusChipType.success
                        : AppStatusChipType.error,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '${movement.quantityBefore}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '${movement.quantityAfter}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: movement.reason ?? '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
              ],
            );
          }).toList();
  }
}
