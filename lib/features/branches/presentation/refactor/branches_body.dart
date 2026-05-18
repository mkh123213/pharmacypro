import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';
import '../cubit/branches_state.dart';
import '../widgets/branch_card.dart';
import '../widgets/branch_form_bottom_sheet.dart';

class BranchesBody extends StatelessWidget {
  const BranchesBody({super.key});

  void _openForm(BuildContext context, {BranchModel? branch}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(value: context.read<BranchesCubit>(), child: BranchFormBottomSheet(branch: branch)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesCubit, BranchesState>(
      builder: (context, state) {
        if (state is BranchesLoading) return const Center(child: CircularProgressIndicator());
        if (state is BranchesFailure) return Center(child: Text(state.message));
        if (state is! BranchesLoaded) return const SizedBox.shrink();
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _FeatureHeader(
            title: 'Branches',
            subtitle: 'Managing ${state.branches.length} branches',
            action: ElevatedButton.icon(onPressed: () => _openForm(context), icon: const Icon(Icons.add), label: const Text('Add Branch')),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: state.branches.isEmpty
                ? const Center(child: Text('No branches yet. Add your first branch!'))
                : LayoutBuilder(builder: (context, constraints) {
                    final count = constraints.maxWidth >= 1000 ? 3 : constraints.maxWidth >= 650 ? 2 : 1;
                    return GridView.builder(
                      itemCount: state.branches.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: count == 1 ? 1.45 : 1.15),
                      itemBuilder: (_, index) => BranchCard(branch: state.branches[index], onEditPressed: () => _openForm(context, branch: state.branches[index])),
                    );
                  }),
          ),
        ]);
      },
    );
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
