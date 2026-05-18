import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../data/models/prescription_model.dart';
import '../cubit/prescriptions_cubit.dart';

class PrescriptionFormBottomSheet extends StatefulWidget {
  const PrescriptionFormBottomSheet({required this.branches, super.key});
  final List<BranchModel> branches;
  @override
  State<PrescriptionFormBottomSheet> createState() => _PrescriptionFormBottomSheetState();
}

class _PrescriptionFormBottomSheetState extends State<PrescriptionFormBottomSheet> {
  final patient = TextEditingController();
  final phone = TextEditingController();
  final doctor = TextEditingController();
  final license = TextEditingController();
  final issueDate = TextEditingController();
  final expiryDate = TextEditingController();
  final notes = TextEditingController();
  String? branchId;

  Future<void> save() async {
    if (patient.text.trim().isEmpty || branchId == null) return;
    final branch = widget.branches.firstWhere((branch) => branch.id == branchId);
    final prescription = PrescriptionModel(
      id: '',
      patientName: patient.text.trim(),
      patientPhone: phone.text.trim(),
      doctorName: doctor.text.trim(),
      doctorLicense: license.text.trim(),
      issueDate: issueDate.text.trim(),
      expiryDate: expiryDate.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      notes: notes.text.trim(),
      prescriptionNumber: 'RX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );
    await context.read<PrescriptionsCubit>().createPrescription(prescription);
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
            Text('New Prescription', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(controller: patient, decoration: const InputDecoration(labelText: 'Patient Name *')),
            const SizedBox(height: 10),
            TextField(controller: phone, decoration: const InputDecoration(labelText: 'Patient Phone')),
            const SizedBox(height: 10),
            TextField(controller: doctor, decoration: const InputDecoration(labelText: 'Doctor Name')),
            const SizedBox(height: 10),
            TextField(controller: license, decoration: const InputDecoration(labelText: 'Doctor License')),
            const SizedBox(height: 10),
            TextField(controller: issueDate, decoration: const InputDecoration(labelText: 'Issue Date')),
            const SizedBox(height: 10),
            TextField(controller: expiryDate, decoration: const InputDecoration(labelText: 'Expiry Date')),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(value: branchId, decoration: const InputDecoration(labelText: 'Branch *'), items: widget.branches.map((branch) => DropdownMenuItem(value: branch.id, child: Text(branch.name))).toList(), onChanged: (value) => setState(() => branchId = value)),
            const SizedBox(height: 10),
            TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Create Prescription'))),
          ]),
        ),
      ),
    ),
  );
}
