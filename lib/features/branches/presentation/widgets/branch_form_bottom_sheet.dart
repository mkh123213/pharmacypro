import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';

class BranchFormBottomSheet extends StatefulWidget {
  const BranchFormBottomSheet({this.branch, super.key});
  final BranchModel? branch;

  @override
  State<BranchFormBottomSheet> createState() => _BranchFormBottomSheetState();
}

class _BranchFormBottomSheetState extends State<BranchFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController name;
  late final TextEditingController city;
  late final TextEditingController address;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController manager;
  late final TextEditingController hours;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    final b = widget.branch;
    name = TextEditingController(text: b?.name ?? '');
    city = TextEditingController(text: b?.city ?? '');
    address = TextEditingController(text: b?.address ?? '');
    phone = TextEditingController(text: b?.phone ?? '');
    email = TextEditingController(text: b?.email ?? '');
    manager = TextEditingController(text: b?.managerName ?? '');
    hours = TextEditingController(text: b?.openingHours ?? '');
    isActive = b?.isActive ?? true;
  }

  @override
  void dispose() {
    name.dispose(); city.dispose(); address.dispose(); phone.dispose(); email.dispose(); manager.dispose(); hours.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final branch = BranchModel(
      id: widget.branch?.id ?? '',
      name: name.text.trim(),
      address: address.text.trim(),
      city: city.text.trim(),
      phone: phone.text.trim(),
      email: email.text.trim(),
      managerName: manager.text.trim(),
      openingHours: hours.text.trim(),
      isActive: isActive,
    );
    if (widget.branch == null) {
      await context.read<BranchesCubit>().createBranch(branch);
    } else {
      await context.read<BranchesCubit>().updateBranch(branch);
    }
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
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(widget.branch == null ? 'Add Branch' : 'Edit Branch', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Branch Name *'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
                const SizedBox(height: 10),
                TextFormField(controller: city, decoration: const InputDecoration(labelText: 'City')),
                const SizedBox(height: 10),
                TextFormField(controller: address, decoration: const InputDecoration(labelText: 'Address *'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
                const SizedBox(height: 10),
                TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
                const SizedBox(height: 10),
                TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 10),
                TextFormField(controller: manager, decoration: const InputDecoration(labelText: 'Manager Name')),
                const SizedBox(height: 10),
                TextFormField(controller: hours, decoration: const InputDecoration(labelText: 'Opening Hours')),
                SwitchListTile(value: isActive, title: const Text('Active / Open'), onChanged: (v) => setState(() => isActive = v)),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: const Text('Save Branch'))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
