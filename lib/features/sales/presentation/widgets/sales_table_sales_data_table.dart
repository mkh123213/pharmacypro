part of 'sales_table.dart';

class _SalesDataTable extends StatelessWidget {
  const _SalesDataTable({required this.sales, this.onDelete});

  final List<SaleModel> sales;
  final ValueChanged<SaleModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: this._buildSalesDataTableColumns(context),
          rows: this._buildSalesDataTableRows(context),
        ),
      ),
    );
  }
}
