part of 'shifts_body.dart';

class _StaffDropdown extends StatelessWidget {
  const _StaffDropdown({required this.staff, required this.selectedStaffId});

  final List<StaffModel> staff;
  final String selectedStaffId;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStaffId,
      decoration: InputDecoration(labelText: context.translate(LangKeys.staff)),
      items: [
        DropdownMenuItem<String>(
          value: allShiftStaffValue,
          child: TextApp(
            text: context.translate(LangKeys.allStaff),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        ...staff.map((member) {
          return DropdownMenuItem<String>(
            value: member.id,
            child: TextApp(
              text: member.fullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          );
        }),
      ],
      onChanged: (value) {
        context.read<ShiftsCubit>().updateSelectedStaff(
          value ?? allShiftStaffValue,
        );
      },
    );
  }
}
