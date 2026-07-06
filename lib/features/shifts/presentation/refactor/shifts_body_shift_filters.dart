part of 'shifts_body.dart';

class _ShiftFilters extends StatelessWidget {
  const _ShiftFilters({required this.state});

  final ShiftsLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1000;

        final search = TextFormField(
          initialValue: state.searchQuery,
          decoration: InputDecoration(
            prefixIcon: AppSearchIcon(),
            hintText: context.translate(LangKeys.searchShifts),
          ),
          onChanged: context.read<ShiftsCubit>().updateSearchQuery,
        );

        final status = _StatusDropdown(selectedStatus: state.selectedStatus);

        final branch = _BranchDropdown(
          branches: state.branches,
          selectedBranchId: state.selectedBranchId,
        );

        final staff = _StaffDropdown(
          staff: state.staff,
          selectedStaffId: state.selectedStaffId,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(flex: 2, child: search),
              SizedBox(width: 12.w),
              Expanded(child: status),
              SizedBox(width: 12.w),
              Expanded(child: branch),
              SizedBox(width: 12.w),
              Expanded(child: staff),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            status,
            SizedBox(height: 12.h),
            branch,
            SizedBox(height: 12.h),
            staff,
          ],
        );
      },
    );
  }
}
