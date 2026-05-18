import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/customer_order_item_model.dart';
import '../../data/models/customer_order_model.dart';
import '../cubit/customer_orders_cubit.dart';

class CustomerOrderFormBottomSheet extends StatefulWidget {
  const CustomerOrderFormBottomSheet({required this.medications, required this.branches, super.key});

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<CustomerOrderFormBottomSheet> createState() => _CustomerOrderFormBottomSheetState();
}

class _CustomerOrderFormBottomSheetState extends State<CustomerOrderFormBottomSheet> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  String orderType = 'pickup';
  String paymentMethod = 'cash';
  String? branchId;
  final items = <CustomerOrderItemModel>[];

  double get total => items.fold(0, (sum, item) => sum + item.total);

  void addFirstMedication() {
    if (widget.medications.isEmpty) return;
    final medication = widget.medications.first;
    setState(() {
      items.add(CustomerOrderItemModel(
        medicationId: medication.id,
        medicationName: medication.name,
        quantity: 1,
        unitPrice: medication.price,
        total: medication.price,
      ));
    });
  }

  Future<void> save() async {
    if (name.text.trim().isEmpty || branchId == null || items.isEmpty) return;
    final branch = widget.branches.firstWhere((branch) => branch.id == branchId);
    final order = CustomerOrderModel(
      id: '',
      customerName: name.text.trim(),
      customerPhone: phone.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      deliveryAddress: orderType == 'delivery' ? address.text.trim() : null,
      orderType: orderType,
      paymentMethod: paymentMethod,
      items: items,
      totalAmount: total,
      orderNumber: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );
    await context.read<CustomerOrdersCubit>().createCustomerOrder(order);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('New Customer Order', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Customer Name *')),
                const SizedBox(height: 10),
                TextField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: orderType,
                  decoration: const InputDecoration(labelText: 'Order Type'),
                  items: const [
                    DropdownMenuItem(value: 'pickup', child: Text('Pickup')),
                    DropdownMenuItem(value: 'delivery', child: Text('Delivery')),
                  ],
                  onChanged: (value) => setState(() => orderType = value ?? orderType),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: branchId,
                  decoration: const InputDecoration(labelText: 'Branch *'),
                  items: widget.branches.map((branch) => DropdownMenuItem(value: branch.id, child: Text(branch.name))).toList(),
                  onChanged: (value) => setState(() => branchId = value),
                ),
                if (orderType == 'delivery') ...[
                  const SizedBox(height: 10),
                  TextField(controller: address, decoration: const InputDecoration(labelText: 'Delivery Address')),
                ],
                const SizedBox(height: 12),
                Row(children: [const Text('Items', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), OutlinedButton.icon(onPressed: addFirstMedication, icon: const Icon(Icons.add), label: const Text('Add'))]),
                ...items.asMap().entries.map((entry) => ListTile(
                  title: Text(entry.value.medicationName),
                  subtitle: Text('Qty: ${entry.value.quantity}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [Text('\$${entry.value.total.toStringAsFixed(2)}'), IconButton(onPressed: () => setState(() => items.removeAt(entry.key)), icon: const Icon(Icons.delete_outline))]),
                )),
                const Divider(),
                Row(children: [const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))]),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Place Order'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
