import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sales_cubit.dart';
import '../cubit/sales_state.dart';
import '../widgets/sale_form_bottom_sheet.dart';
import '../widgets/sales_table.dart';

class SalesBody extends StatelessWidget {
  const SalesBody({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<SalesCubit, SalesState>(builder: (context, state) {
    if (state is SalesLoading) return const Center(child: CircularProgressIndicator());
    if (state is SalesFailure) return Center(child: Text(state.message));
    if (state is! SalesLoaded) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Sales & POS', subtitle: 'Process sales and view transaction history', action: ElevatedButton.icon(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<SalesCubit>(), child: SaleFormBottomSheet(medications: state.medications, branches: state.branches))), icon: const Icon(Icons.add), label: const Text('New Sale'))), const SizedBox(height: 14), TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search sales...'), onChanged: context.read<SalesCubit>().updateSearchQuery), const SizedBox(height: 14), Expanded(child: state.sales.isEmpty ? const Center(child: Text('No sales found')) : SalesTable(sales: state.sales))]);
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
