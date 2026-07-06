part of 'branches_body.dart';

class _BranchesFilters extends StatelessWidget {
  const _BranchesFilters({required this.state});

  final BranchesLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;

        final search = TextFormField(
          initialValue: state.searchQuery,
          onChanged: context.read<BranchesCubit>().updateSearchQuery,
          decoration: InputDecoration(
            prefixIcon: AppSearchIcon(),
            hintText: context.translate(LangKeys.searchBranches),
          ),
        );

        final status = _BranchStatusDropdown(
          selectedStatus: state.selectedStatus,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 200.w, child: status),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            status,
          ],
        );
      },
    );
  }
}
