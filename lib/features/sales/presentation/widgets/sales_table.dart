import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/sale_model.dart';

class SalesTable extends StatelessWidget {
  const SalesTable({required this.sales, super.key});
  final List<SaleModel> sales;
  @override
  Widget build(BuildContext context) => Card(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Sale #')), DataColumn(label: Text('Date')), DataColumn(label: Text('Customer')), DataColumn(label: Text('Branch')), DataColumn(label: Text('Items')), DataColumn(label: Text('Total')), DataColumn(label: Text('Payment')), DataColumn(label: Text('Status'))], rows: sales.map((s) => DataRow(cells: [DataCell(Text(s.saleNumber ?? s.id.substring(0, s.id.length.clamp(0, 6)))), DataCell(Text(s.createdAt == null ? '—' : DateFormat('MMM d, HH:mm').format(s.createdAt!))), DataCell(Text(s.customerName ?? 'Walk-in')), DataCell(Text(s.branchName ?? '')), DataCell(Text('${s.items.length} items')), DataCell(Text('\$${s.totalAmount.toStringAsFixed(2)}')), DataCell(Text(s.paymentMethod)), DataCell(Chip(label: Text(s.status)))])).toList())));
}
