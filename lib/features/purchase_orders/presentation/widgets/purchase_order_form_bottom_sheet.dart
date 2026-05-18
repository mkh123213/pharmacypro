import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../../data/models/purchase_order_item_model.dart';
import '../../data/models/purchase_order_model.dart';
import '../cubit/purchase_orders_cubit.dart';

class PurchaseOrderFormBottomSheet extends StatefulWidget {
  const PurchaseOrderFormBottomSheet({required this.suppliers, required this.branches, required this.medications, super.key});
  final List<SupplierModel> suppliers;
  final List<BranchModel> branches;
  final List<MedicationModel> medications;
  @override
  State<PurchaseOrderFormBottomSheet> createState() => _PurchaseOrderFormBottomSheetState();
}

class _PurchaseOrderFormBottomSheetState extends State<PurchaseOrderFormBottomSheet> {
  String? supplierId;
  String? branchId;
  final orderDate = TextEditingController();
  final expectedDelivery = TextEditingController();
  final notes = TextEditingController();
  final items = <PurchaseOrderItemModel>[];
  double get total => items.fold(0, (sum, item) => sum + item.total);

  void addFirstMedication() {
    if (widget.medications.isEmpty) return;
    final medication = widget.medications.first;
    final cost = medication.costPrice ?? medication.price;
    setState(() => items.add(PurchaseOrderItemModel(medicationId: medication.id, medicationName: medication.name, quantity: 1, unitCost: cost, total: cost)));
  }

  Future<void> save() async {
    if (supplierId == null || branchId == null) return;
    final supplier = widget.suppliers.firstWhere((supplier) => supplier.id == supplierId);
    final branch = widget.branches.firstWhere((branch) => branch.id == branchId);
    final order = PurchaseOrderModel(
      id: '',
      supplierId: supplier.id,
      supplierName: supplier.name,
      branchId: branch.id,
      branchName: branch.name,
      orderDate: orderDate.text.trim(),
      expectedDelivery: expectedDelivery.text.trim(),
      totalAmount: total,
      items: items,
      notes: notes.text.trim(),
      orderNumber: 'PO-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );
    await context.read<PurchaseOrdersCubit>().createPurchaseOrder(order);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('New Purchase Order', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(value: supplierId, decoration: const InputDecoration(labelText: 'Supplier *'), items: widget.suppliers.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(), onChanged: (value) => setState(() => supplierId = value)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(value: branchId, decoration: const InputDecoration(labelText: 'Branch *'), items: widget.branches.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name))).toList(), onChanged: (value) => setState(() => branchId = value)),
            const SizedBox(height: 10),
            TextField(controller: orderDate, decoration: const InputDecoration(labelText: 'Order Date')),
            const SizedBox(height: 10),
            TextField(controller: expectedDelivery, decoration: const InputDecoration(labelText: 'Expected Delivery')),
            const SizedBox(height: 12),
            Row(children: [const Text('Items', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), OutlinedButton.icon(onPressed: addFirstMedication, icon: const Icon(Icons.add), label: const Text('Add'))]),
            ...items.asMap().entries.map((entry) => ListTile(title: Text(entry.value.medicationName), subtitle: Text('Qty: ${entry.value.quantity}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [Text('\$${entry.value.total.toStringAsFixed(2)}'), IconButton(onPressed: () => setState(() => items.removeAt(entry.key)), icon: const Icon(Icons.delete_outline))]))),
            TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            const Divider(),
            Row(children: [const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))]),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Create Purchase Order'))),
          ]),
        ),
      ),
    ),
  );
}
