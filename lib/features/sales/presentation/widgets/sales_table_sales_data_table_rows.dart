part of 'sales_table.dart';

extension SalesDataTableRows on _SalesDataTable {
  List<DataRow> _buildSalesDataTableRows(BuildContext context) {
    return sales.map((sale) {
            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text: _saleNumber(sale),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: _dateText(sale),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text:
                        sale.customerName ?? context.translate(LangKeys.walkIn),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: sale.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: context
                        .translate(LangKeys.itemsCount)
                        .replaceAll('{count}', sale.items.length.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '\$${sale.totalAmount.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: _paymentLabel(context, sale.paymentMethod),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: _statusLabel(context, sale.status),
                    type: _statusType(sale.status),
                  ),
                ),
                if (onDelete != null)
                  DataCell(
                    IconButton(
                      onPressed: () => onDelete!(sale),
                      icon: Icon(Icons.delete_outline, size: 19.sp, color: Colors.red),
                    ),
                  ),
              ],
            );
          }).toList();
  }
}
