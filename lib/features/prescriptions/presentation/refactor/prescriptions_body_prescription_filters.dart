part of 'prescriptions_body.dart';

class _PrescriptionFilters extends StatelessWidget {
  const _PrescriptionFilters({required this.state});

  final PrescriptionsLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;

        final searchField = TextFormField(
          initialValue: state.searchQuery,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: context.translate(LangKeys.searchPrescriptions),
          ),
          onChanged: context.read<PrescriptionsCubit>().updateSearchQuery,
        );

        final statusDropdown = _StatusDropdown(
          selectedStatus: state.selectedStatus,
        );

        final branchDropdown = _BranchDropdown(
          branches: state.branches,
          selectedBranchId: state.selectedBranchId,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(flex: 2, child: searchField),
              SizedBox(width: 12.w),
              Expanded(child: statusDropdown),
              SizedBox(width: 12.w),
              Expanded(child: branchDropdown),
            ],
          );
        }

        return Column(
          children: [
            searchField,
            SizedBox(height: 12.h),
            statusDropdown,
            SizedBox(height: 12.h),
            branchDropdown,
          ],
        );
      },
    );
  }
}
