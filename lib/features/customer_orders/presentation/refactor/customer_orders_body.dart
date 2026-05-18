import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/customer_orders_cubit.dart';
import '../cubit/customer_orders_state.dart';
import '../widgets/customer_order_card.dart';
import '../widgets/customer_order_form_bottom_sheet.dart';
import 'customer_orders_constants.dart';

class CustomerOrdersBody extends StatelessWidget {
  const CustomerOrdersBody({super.key});
  static const nextStatus = {'pending':'confirmed','confirmed':'processing','processing':'ready','ready':'out_for_delivery','out_for_delivery':'delivered'};
  @override
  Widget build(BuildContext context) => BlocBuilder<CustomerOrdersCubit, CustomerOrdersState>(builder: (context, state) {
    if (state is CustomerOrdersLoading) return const Center(child: CircularProgressIndicator());
    if (state is CustomerOrdersFailure) return Center(child: Text(state.message));
    if (state is! CustomerOrdersLoaded) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FeatureHeader(title: 'Customer Orders', subtitle: 'Browse and manage online/pickup orders', action: ElevatedButton.icon(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<CustomerOrdersCubit>(), child: CustomerOrderFormBottomSheet(medications: state.medications, branches: state.branches))), icon: const Icon(Icons.add), label: const Text('New Order'))), const SizedBox(height: 14), Row(children: [Expanded(child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search orders...'), onChanged: context.read<CustomerOrdersCubit>().updateSearchQuery)), const SizedBox(width: 12), SizedBox(width: 190, child: DropdownButtonFormField<String>(value: state.selectedStatus, items: customerOrderStatuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => context.read<CustomerOrdersCubit>().updateSelectedStatus(v ?? 'all')))]), const SizedBox(height: 14), Expanded(child: state.orders.isEmpty ? const Center(child: Text('No orders found')) : ListView.separated(itemCount: state.orders.length, separatorBuilder: (_, __) => const SizedBox(height: 8), itemBuilder: (_, i) { final order = state.orders[i]; final next = nextStatus[order.status]; return CustomerOrderCard(order: order, onNextStatus: next == null ? null : () => context.read<CustomerOrdersCubit>().updateStatus(order.id, next)); }))]);
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
