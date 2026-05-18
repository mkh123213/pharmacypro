import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/prescriptions_cubit.dart';
import '../cubit/prescriptions_state.dart';
import '../widgets/prescription_details_bottom_sheet.dart';
import '../widgets/prescription_form_bottom_sheet.dart';
import '../widgets/prescriptions_table.dart';
import 'prescriptions_constants.dart';

class PrescriptionsBody extends StatelessWidget {
  const PrescriptionsBody({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<PrescriptionsCubit, PrescriptionsState>(builder: (context, state) {
    if (state is PrescriptionsLoading) return const Center(child: CircularProgressIndicator());
    if (state is PrescriptionsFailure) return Center(child: Text(state.message));
    if (state is! PrescriptionsLoaded) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Prescriptions', subtitle: 'Manage and verify patient prescriptions', action: ElevatedButton.icon(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<PrescriptionsCubit>(), child: PrescriptionFormBottomSheet(branches: state.branches))), icon: const Icon(Icons.add), label: const Text('New Prescription'))), const SizedBox(height: 14), Row(children: [Expanded(child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search patient, doctor, number...'), onChanged: context.read<PrescriptionsCubit>().updateSearchQuery)), const SizedBox(width: 12), SizedBox(width: 170, child: DropdownButtonFormField<String>(value: state.selectedStatus, items: prescriptionStatuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => context.read<PrescriptionsCubit>().updateSelectedStatus(v ?? 'all')))]), const SizedBox(height: 14), Expanded(child: state.prescriptions.isEmpty ? const Center(child: Text('No prescriptions found')) : PrescriptionsTable(prescriptions: state.prescriptions, onView: (p) => showPrescriptionDetailsBottomSheet(context, p), onVerify: (p) => context.read<PrescriptionsCubit>().updateStatus(p.id, 'verified'), onReject: (p) => context.read<PrescriptionsCubit>().updateStatus(p.id, 'rejected'), onDispense: (p) => context.read<PrescriptionsCubit>().updateStatus(p.id, 'dispensed')))]);
  });
}


class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({required this.title, required this.subtitle, this.action});
  final String title;
  final String subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Colors.grey.shade600))])), if (action != null) action!]);
}
