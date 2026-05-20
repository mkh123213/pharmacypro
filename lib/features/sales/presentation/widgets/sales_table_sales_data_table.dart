part of 'sales_table.dart';

class _SalesDataTable extends StatelessWidget {
  const _SalesDataTable({required this.sales});

  final List<SaleModel> sales;

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
