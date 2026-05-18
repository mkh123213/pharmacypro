import 'package:flutter/material.dart';
import '../../data/models/purchase_order_model.dart';
void showPurchaseOrderDetailsBottomSheet(BuildContext context, PurchaseOrderModel order) { showModalBottomSheet(context: context, builder: (_) => SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Purchase Order - ${order.orderNumber ?? order.id}', style: Theme.of(context).textTheme.titleLarge), ...order.items.map((i) => ListTile(title: Text(i.medicationName), trailing: Text('\$${i.total.toStringAsFixed(2)}')))])))); }
