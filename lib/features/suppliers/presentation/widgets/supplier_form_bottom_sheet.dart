import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';

class SupplierFormBottomSheet extends StatefulWidget {
  const SupplierFormBottomSheet({this.supplier, super.key});
  final SupplierModel? supplier;

  @override
  State<SupplierFormBottomSheet> createState() =>
      _SupplierFormBottomSheetState();
}

class _SupplierFormBottomSheetState extends State<SupplierFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController name;
  late final TextEditingController contact;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController address;
  late final TextEditingController paymentTerms;
  late final TextEditingController notes;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    final s = widget.supplier;
    name = TextEditingController(text: s?.name ?? '');
    contact = TextEditingController(text: s?.contactPerson ?? '');
    phone = TextEditingController(text: s?.phone ?? '');
    email = TextEditingController(text: s?.email ?? '');
    address = TextEditingController(text: s?.address ?? '');
    paymentTerms = TextEditingController(text: s?.paymentTerms ?? '');
    notes = TextEditingController(text: s?.notes ?? '');
    isActive = s?.isActive ?? true;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final supplier = SupplierModel(
      id: widget.supplier?.id ?? '',
      name: name.text.trim(),
      contactPerson: contact.text.trim(),
      phone: phone.text.trim(),
      email: email.text.trim(),
      address: address.text.trim(),
      paymentTerms: paymentTerms.text.trim(),
      notes: notes.text.trim(),
      isActive: isActive,
    );
    if (widget.supplier == null)
      await context.read<SuppliersCubit>().createSupplier(supplier);
    else
      await context.read<SuppliersCubit>().updateSupplier(supplier);
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.supplier == null ? 'Add Supplier' : 'Edit Supplier',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Company Name *',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: contact,
                    decoration: const InputDecoration(
                      labelText: 'Contact Person',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: paymentTerms,
                    decoration: const InputDecoration(
                      labelText: 'Payment Terms',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: address,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: notes,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                  SwitchListTile(
                    value: isActive,
                    title: const Text('Active'),
                    onChanged: (v) => setState(() => isActive = v),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save Supplier'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
