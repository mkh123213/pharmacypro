import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../cubit/purchase_orders_state.dart';
import '../widgets/purchase_order_details_bottom_sheet.dart';
import '../widgets/purchase_order_form_bottom_sheet.dart';
import '../widgets/purchase_orders_table.dart';

class PurchaseOrdersBody extends StatelessWidget {
  const PurchaseOrdersBody({super.key});
  static const next = {'draft':'sent','sent':'confirmed','confirmed':'received'};
  @override
  Widget build(BuildContext context) => BlocBuilder<PurchaseOrdersCubit, PurchaseOrdersState>(builder: (context, state) {
    if (state is PurchaseOrdersLoading) return const Center(child: CircularProgressIndicator());
    if (state is PurchaseOrdersFailure) return Center(child: Text(state.message));
    if (state is! PurchaseOrdersLoaded) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Purchase Orders', subtitle: 'Manage supplier purchase orders', action: ElevatedButton.icon(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<PurchaseOrdersCubit>(), child: PurchaseOrderFormBottomSheet(suppliers: state.suppliers, branches: state.branches, medications: state.medications))), icon: const Icon(Icons.add), label: const Text('New Order'))), const SizedBox(height: 14), TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search orders...'), onChanged: context.read<PurchaseOrdersCubit>().updateSearchQuery), const SizedBox(height: 14), Expanded(child: state.purchaseOrders.isEmpty ? const Center(child: Text('No purchase orders')) : PurchaseOrdersTable(orders: state.purchaseOrders, onView: (o) => showPurchaseOrderDetailsBottomSheet(context, o), onNextStatus: (o) { final s = next[o.status]; if (s != null) context.read<PurchaseOrdersCubit>().updateStatus(o.id, s); }))]);
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
