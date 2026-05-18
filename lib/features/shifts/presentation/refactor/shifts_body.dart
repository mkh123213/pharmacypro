import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/shifts_cubit.dart';
import '../cubit/shifts_state.dart';
import '../widgets/shift_form_bottom_sheet.dart';
import '../widgets/shift_week_view.dart';
import '../widgets/shifts_table.dart';

class ShiftsBody extends StatelessWidget { const ShiftsBody({super.key}); @override Widget build(BuildContext context) => BlocBuilder<ShiftsCubit, ShiftsState>(builder: (context, state) { if (state is ShiftsLoading) return const Center(child: CircularProgressIndicator()); if (state is ShiftsFailure) return Center(child: Text(state.message)); if (state is! ShiftsLoaded) return const SizedBox.shrink(); return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Shifts', subtitle: 'Schedule and track staff shifts', action: ElevatedButton.icon(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<ShiftsCubit>(), child: ShiftFormBottomSheet(staff: state.staff, branches: state.branches))), icon: const Icon(Icons.add), label: const Text('Add Shift'))), const SizedBox(height: 14), Row(children: [OutlinedButton(onPressed: context.read<ShiftsCubit>().previousWeek, child: const Text('Prev Week')), const Spacer(), OutlinedButton(onPressed: context.read<ShiftsCubit>().nextWeek, child: const Text('Next Week'))]), const SizedBox(height: 14), SizedBox(height: 240, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SizedBox(width: 900, child: ShiftWeekView(weekStart: state.weekStart, shifts: state.shifts, onShiftTap: (s) { final next = s.status == 'scheduled' ? 'in_progress' : s.status == 'in_progress' ? 'completed' : s.status; context.read<ShiftsCubit>().updateStatus(s.id, next); })))), const SizedBox(height: 20), const Text('All Upcoming Shifts', style: TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 10), Expanded(child: ShiftsTable(shifts: state.shifts))]); }); }


class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({required this.title, required this.subtitle, this.action});
  final String title;
  final String subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Colors.grey.shade600))])), if (action != null) action!]);
}
