part of 'inventory_table.dart';

class _InventoryDataTable extends StatelessWidget {
  const _InventoryDataTable({
    required this.items,
    required this.onTap,
    required this.onAdjustStock,
    required this.isSubmitting,
    this.onDelete,
  });

  final List<InventoryModel> items;
  final ValueChanged<InventoryModel> onTap;
  final ValueChanged<InventoryModel> onAdjustStock;
  final bool isSubmitting;
  final ValueChanged<InventoryModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: this._buildInventoryDataTableColumns(context),
          rows: this._buildInventoryDataTableRows(context),
        ),
      ),
    );
  }
}
