import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';
import '../widgets/inventory_form_bottom_sheet.dart';
import '../widgets/inventory_table.dart';

class InventoryBody extends StatelessWidget {
  const InventoryBody({super.key});
  void openForm(BuildContext context, InventoryLoaded state, {InventoryModel? item}) => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<InventoryCubit>(), child: InventoryFormBottomSheet(medications: state.medications, branches: state.branches, item: item)));
  @override
  Widget build(BuildContext context) => BlocBuilder<InventoryCubit, InventoryState>(builder: (context, state) {
    if (state is InventoryLoading) return const Center(child: CircularProgressIndicator());
    if (state is InventoryFailure) return Center(child: Text(state.message));
    if (state is! InventoryLoaded) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _FeatureHeader(title: 'Inventory', subtitle: 'Track stock levels across all branches', action: ElevatedButton.icon(onPressed: () => openForm(context, state), icon: const Icon(Icons.add), label: const Text('Add Stock'))), const SizedBox(height: 14),
      Row(children: [Expanded(child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search medications...'), onChanged: context.read<InventoryCubit>().updateSearchQuery)), const SizedBox(width: 12), SizedBox(width: 190, child: DropdownButtonFormField<String>(value: state.selectedBranchId, items: [const DropdownMenuItem(value: 'all', child: Text('All Branches')), ...state.branches.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name)))], onChanged: (v) => context.read<InventoryCubit>().updateSelectedBranch(v ?? 'all')))]), const SizedBox(height: 14),
      Expanded(child: state.inventory.isEmpty ? const Center(child: Text('No inventory records found')) : InventoryTable(items: state.inventory, onTap: (item) => openForm(context, state, item: item))),
    ]);
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
