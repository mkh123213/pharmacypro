part of 'staff_body.dart';

class _StaffGrid extends StatelessWidget {
  const _StaffGrid({required this.staff, required this.onEditPressed, required this.onDeletePressed});

  final List<StaffModel> staff;
  final ValueChanged<StaffModel> onEditPressed;
  final ValueChanged<StaffModel> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 700
            ? 2
            : 1;

        return GridView.builder(
          itemCount: staff.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: count == 1 ? 1.55 : 1.15,
          ),
          itemBuilder: (_, index) {
            final staffMember = staff[index];

            return StaffCard(
              staff: staffMember,
              onEditPressed: () {
                onEditPressed(staffMember);
              },
              onDeletePressed: () {
                onDeletePressed(staffMember);
              },
            );
          },
        );
      },
    );
  }
}
