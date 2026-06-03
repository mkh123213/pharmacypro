part of 'staff_body.dart';

extension StaffBodyOpenForm on StaffBody {
void _openForm(BuildContext context, StaffLoaded state, {StaffModel? staff}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<StaffCubit>(),
          child: StaffFormBottomSheet(staff: staff, branches: state.branches),
        );
      },
    );
  }
}
