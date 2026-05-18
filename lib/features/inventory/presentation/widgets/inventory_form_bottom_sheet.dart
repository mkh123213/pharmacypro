import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';

class InventoryFormBottomSheet extends StatefulWidget {
  const InventoryFormBottomSheet({required this.medications, required this.branches, this.item, super.key});
  final List<MedicationModel> medications;
  final List<BranchModel> branches;
  final InventoryModel? item;
  @override
  State<InventoryFormBottomSheet> createState() => _InventoryFormBottomSheetState();
}
class _InventoryFormBottomSheetState extends State<InventoryFormBottomSheet> {
  late String? medicationId = widget.item?.medicationId ?? (widget.medications.isNotEmpty ? widget.medications.first.id : null);
  late String? branchId = widget.item?.branchId ?? (widget.branches.isNotEmpty ? widget.branches.first.id : null);
  late final quantity = TextEditingController(text: widget.item?.quantity.toString() ?? '0');
  late final min = TextEditingController(text: widget.item?.minStockLevel.toString() ?? '10');
  late final batch = TextEditingController(text: widget.item?.batchNumber ?? '');
  late final expiry = TextEditingController(text: widget.item?.expiryDate ?? '');
  late final location = TextEditingController(text: widget.item?.locationInStore ?? '');
  Future<void> save() async {
    if (medicationId == null || branchId == null) return;
    final med = widget.medications.firstWhere((m) => m.id == medicationId);
    final branch = widget.branches.firstWhere((b) => b.id == branchId);
    final model = InventoryModel(id: widget.item?.id ?? '', medicationId: med.id, medicationName: med.name, branchId: branch.id, branchName: branch.name, quantity: int.tryParse(quantity.text) ?? 0, minStockLevel: int.tryParse(min.text) ?? 10, batchNumber: batch.text.trim(), expiryDate: expiry.text.trim(), locationInStore: location.text.trim());
    if (widget.item == null) await context.read<InventoryCubit>().createInventory(model); else await context.read<InventoryCubit>().updateInventory(model);
    if (mounted) Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom), child: Material(borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), child: SafeArea(top: false, child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
    Text(widget.item == null ? 'Add Stock' : 'Edit Inventory', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 16),
    DropdownButtonFormField<String>(value: medicationId, items: widget.medications.map((m) => DropdownMenuItem(value: m.id, child: Text(m.name))).toList(), onChanged: (v) => setState(() => medicationId = v), decoration: const InputDecoration(labelText: 'Medication')), const SizedBox(height: 10),
    DropdownButtonFormField<String>(value: branchId, items: widget.branches.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name))).toList(), onChanged: (v) => setState(() => branchId = v), decoration: const InputDecoration(labelText: 'Branch')), const SizedBox(height: 10),
    TextField(controller: quantity, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity')), const SizedBox(height: 10), TextField(controller: min, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Min Stock Level')), const SizedBox(height: 10),
    TextField(controller: batch, decoration: const InputDecoration(labelText: 'Batch Number')), const SizedBox(height: 10), TextField(controller: expiry, decoration: const InputDecoration(labelText: 'Expiry Date')), const SizedBox(height: 10), TextField(controller: location, decoration: const InputDecoration(labelText: 'Location in Store')), const SizedBox(height: 16),
    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Save'))),
  ])))));
}
