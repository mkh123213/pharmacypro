part of 'purchase_orders_table.dart';

class _PurchaseOrdersDataTable extends StatelessWidget {
  const _PurchaseOrdersDataTable({
    required this.orders,
    required this.onView,
    required this.onEdit,
    required this.onNextStatus,
    required this.onCancel,
    required this.isSubmitting,
    this.onDelete,
  });

  final List<PurchaseOrderModel> orders;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onEdit;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  final ValueChanged<PurchaseOrderModel> onCancel;
  final bool isSubmitting;
  final ValueChanged<PurchaseOrderModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: this._buildPurchaseOrdersDataTableColumns(context),
          rows: this._buildPurchaseOrdersDataTableRows(context),
        ),
      ),
    );
  }
}
