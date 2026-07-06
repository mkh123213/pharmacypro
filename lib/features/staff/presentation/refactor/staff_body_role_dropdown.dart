part of 'staff_body.dart';

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown({required this.selectedRole});

  final String selectedRole;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedRole,
      decoration: InputDecoration(labelText: context.translate(LangKeys.role)),
      items: staffRoleOptions.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Row(
            children: [
              AppImageAssetPreviewer(
                formatStaffImagePath(context, role),
                width: 20.w,
                height: 20.h,
              ),
              TextApp(
                text: formatStaffRole(context, role),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        context.read<StaffCubit>().updateSelectedRole(value);
      },
    );
  }
}
