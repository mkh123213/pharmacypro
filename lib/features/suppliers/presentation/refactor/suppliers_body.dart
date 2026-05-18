import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';
import '../cubit/suppliers_state.dart';
import '../widgets/supplier_card.dart';
import '../widgets/supplier_form_bottom_sheet.dart';

class SuppliersBody extends StatelessWidget {
  const SuppliersBody({super.key});

  void _openForm(BuildContext context, {SupplierModel? supplier}) => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => BlocProvider.value(value: context.read<SuppliersCubit>(), child: SupplierFormBottomSheet(supplier: supplier)));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuppliersCubit, SuppliersState>(builder: (context, state) {
      if (state is SuppliersLoading) return const Center(child: CircularProgressIndicator());
      if (state is SuppliersFailure) return Center(child: Text(state.message));
      if (state is! SuppliersLoaded) return const SizedBox.shrink();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _FeatureHeader(title: 'Suppliers', subtitle: 'Manage your medication suppliers', action: ElevatedButton.icon(onPressed: () => _openForm(context), icon: const Icon(Icons.add), label: const Text('Add Supplier'))),
        const SizedBox(height: 16),
        TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search suppliers...'), onChanged: context.read<SuppliersCubit>().updateSearchQuery),
        const SizedBox(height: 16),
        Expanded(child: state.suppliers.isEmpty ? const Center(child: Text('No suppliers found')) : LayoutBuilder(builder: (context, constraints) {
          final count = constraints.maxWidth >= 1000 ? 3 : constraints.maxWidth >= 650 ? 2 : 1;
          return GridView.builder(itemCount: state.suppliers.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: count == 1 ? 1.6 : 1.2), itemBuilder: (_, index) => SupplierCard(supplier: state.suppliers[index], onEditPressed: () => _openForm(context, supplier: state.suppliers[index])));
        })),
      ]);
    });
  }
}


class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({required this.title, required this.subtitle, this.action});

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)),
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}
