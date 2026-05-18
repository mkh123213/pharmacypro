import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../../data/models/shift_model.dart';
import '../cubit/shifts_cubit.dart';

class ShiftFormBottomSheet extends StatefulWidget {
  const ShiftFormBottomSheet({required this.staff, required this.branches, super.key});
  final List<StaffModel> staff;
  final List<BranchModel> branches;
  @override
  State<ShiftFormBottomSheet> createState() => _ShiftFormBottomSheetState();
}

class _ShiftFormBottomSheetState extends State<ShiftFormBottomSheet> {
  String? staffId;
  String? branchId;
  final date = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  final notes = TextEditingController();

  Future<void> save() async {
    if (staffId == null || branchId == null || date.text.trim().isEmpty || start.text.trim().isEmpty || end.text.trim().isEmpty) return;
    final member = widget.staff.firstWhere((item) => item.id == staffId);
    final branch = widget.branches.firstWhere((item) => item.id == branchId);
    final shift = ShiftModel(id: '', staffId: member.id, staffName: member.fullName, branchId: branch.id, branchName: branch.name, date: date.text.trim(), startTime: start.text.trim(), endTime: end.text.trim(), notes: notes.text.trim());
    await context.read<ShiftsCubit>().createShift(shift);
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
            Text('Add Shift', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(value: staffId, decoration: const InputDecoration(labelText: 'Staff Member *'), items: widget.staff.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.fullName} - ${s.role}'))).toList(), onChanged: (value) => setState(() => staffId = value)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(value: branchId, decoration: const InputDecoration(labelText: 'Branch *'), items: widget.branches.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name))).toList(), onChanged: (value) => setState(() => branchId = value)),
            const SizedBox(height: 10),
            TextField(controller: date, decoration: const InputDecoration(labelText: 'Date *', hintText: 'yyyy-MM-dd')),
            const SizedBox(height: 10),
            TextField(controller: start, decoration: const InputDecoration(labelText: 'Start Time *', hintText: '08:00')),
            const SizedBox(height: 10),
            TextField(controller: end, decoration: const InputDecoration(labelText: 'End Time *', hintText: '16:00')),
            const SizedBox(height: 10),
            TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Schedule Shift'))),
          ]),
        ),
      ),
    ),
  );
}
