import 'package:flutter/material.dart';
import '../../data/models/inventory_model.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({required this.items, required this.onTap, super.key});
  final List<InventoryModel> items;
  final ValueChanged<InventoryModel> onTap;
  @override
  Widget build(BuildContext context) => Card(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Medication')), DataColumn(label: Text('Branch')), DataColumn(label: Text('Qty')), DataColumn(label: Text('Min')), DataColumn(label: Text('Expiry')), DataColumn(label: Text('Batch')), DataColumn(label: Text('Status'))], rows: items.map((item) => DataRow(onSelectChanged: (_) => onTap(item), cells: [DataCell(Text(item.medicationName ?? '')), DataCell(Text(item.branchName ?? '')), DataCell(Text('${item.quantity}', style: TextStyle(color: item.isLowStock ? Colors.red : null, fontWeight: FontWeight.w700))), DataCell(Text('${item.minStockLevel}')), DataCell(Text(item.expiryDate ?? '—')), DataCell(Text(item.batchNumber ?? '—')), DataCell(Chip(label: Text(item.isLowStock ? 'Low' : 'OK'), backgroundColor: item.isLowStock ? Colors.red.shade50 : Colors.green.shade50))])).toList())));
}
