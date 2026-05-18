import 'package:flutter/material.dart';
import '../../data/models/purchase_order_model.dart';

class PurchaseOrdersTable extends StatelessWidget {
  const PurchaseOrdersTable({required this.orders, required this.onView, required this.onNextStatus, super.key});
  final List<PurchaseOrderModel> orders;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  @override
  Widget build(BuildContext context) => Card(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Order #')), DataColumn(label: Text('Supplier')), DataColumn(label: Text('Branch')), DataColumn(label: Text('Total')), DataColumn(label: Text('Status')), DataColumn(label: Text('Actions'))], rows: orders.map((o) => DataRow(cells: [DataCell(Text(o.orderNumber ?? o.id)), DataCell(Text(o.supplierName ?? '')), DataCell(Text(o.branchName ?? '')), DataCell(Text('\$${o.totalAmount.toStringAsFixed(2)}')), DataCell(Chip(label: Text(o.status))), DataCell(Row(children: [IconButton(onPressed: () => onView(o), icon: const Icon(Icons.visibility_outlined)), TextButton(onPressed: () => onNextStatus(o), child: const Text('Next'))]))])).toList())));
}
