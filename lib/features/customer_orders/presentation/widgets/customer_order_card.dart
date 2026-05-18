import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/customer_order_model.dart';

class CustomerOrderCard extends StatelessWidget {
  const CustomerOrderCard({required this.order, required this.onNextStatus, super.key});
  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.shopping_bag_outlined)), title: Text(order.customerName), subtitle: Text('${order.branchName ?? ''} · ${order.orderType}\n${order.items.map((e) => '${e.medicationName} x${e.quantity}').join(', ')}'), isThreeLine: true, trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('\$${order.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)), Text(order.createdAt == null ? '' : DateFormat('MMM d').format(order.createdAt!)), Chip(label: Text(order.status)), if (onNextStatus != null) TextButton(onPressed: onNextStatus, child: const Text('Next'))])));
}
