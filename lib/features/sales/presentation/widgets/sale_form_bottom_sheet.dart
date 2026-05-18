import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/sale_item_model.dart';
import '../../data/models/sale_model.dart';
import '../cubit/sales_cubit.dart';

class SaleFormBottomSheet extends StatefulWidget {
  const SaleFormBottomSheet({required this.medications, required this.branches, super.key});
  final List<MedicationModel> medications;
  final List<BranchModel> branches;
  @override
  State<SaleFormBottomSheet> createState() => _SaleFormBottomSheetState();
}
class _SaleFormBottomSheetState extends State<SaleFormBottomSheet> {
  String? branchId;
  String payment = 'cash';
  final customer = TextEditingController();
  final phone = TextEditingController();
  final discount = TextEditingController();
  final items = <SaleItemModel>[];
  double get subtotal => items.fold(0, (s, i) => s + i.total);
  double get total => subtotal - (double.tryParse(discount.text) ?? 0);
  void addFirstItem() { if (widget.medications.isEmpty) return; final m = widget.medications.first; setState(() => items.add(SaleItemModel(medicationId: m.id, medicationName: m.name, quantity: 1, unitPrice: m.price, total: m.price))); }
  Future<void> save() async { if (branchId == null || items.isEmpty) return; final branch = widget.branches.firstWhere((b) => b.id == branchId); final sale = SaleModel(id: '', branchId: branch.id, branchName: branch.name, customerName: customer.text.trim(), customerPhone: phone.text.trim(), items: items, subtotal: subtotal, discount: double.tryParse(discount.text) ?? 0, totalAmount: total, paymentMethod: payment, saleNumber: 'S-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}'); await context.read<SalesCubit>().createSale(sale); if (mounted) Navigator.pop(context); }
  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom), child: Material(borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), child: SafeArea(top: false, child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [Text('New Sale', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12), DropdownButtonFormField<String>(value: branchId, items: widget.branches.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name))).toList(), onChanged: (v) => setState(() => branchId = v), decoration: const InputDecoration(labelText: 'Branch *')), const SizedBox(height: 10), DropdownButtonFormField<String>(value: payment, items: ['cash','card','insurance','online'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => payment = v ?? payment), decoration: const InputDecoration(labelText: 'Payment Method')), const SizedBox(height: 10), TextField(controller: customer, decoration: const InputDecoration(labelText: 'Customer Name')), const SizedBox(height: 10), TextField(controller: phone, decoration: const InputDecoration(labelText: 'Customer Phone')), const SizedBox(height: 12), Align(alignment: Alignment.centerLeft, child: OutlinedButton.icon(onPressed: addFirstItem, icon: const Icon(Icons.add), label: const Text('Add Item'))), ...items.map((i) => ListTile(title: Text(i.medicationName), trailing: Text('\$${i.total.toStringAsFixed(2)}'))), TextField(controller: discount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Discount'), onChanged: (_) => setState(() {})), const SizedBox(height: 10), Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Complete Sale')))])))));
}
