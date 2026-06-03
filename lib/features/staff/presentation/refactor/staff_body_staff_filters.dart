part of 'staff_body.dart';

class _StaffFilters extends StatelessWidget {
  const _StaffFilters({required this.state});

  final StaffLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;

        final search = TextField(
          onChanged: context.read<StaffCubit>().updateSearchQuery,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: context.translate(LangKeys.searchStaff),
          ),
        );

        final role = _RoleDropdown(selectedRole: state.selectedRole);

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 200.w, child: role),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            role,
          ],
        );
      },
    );
  }
}
