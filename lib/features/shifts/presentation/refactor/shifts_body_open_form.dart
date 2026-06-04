part of 'shifts_body.dart';

extension ShiftsBodyOpenForm on ShiftsBody {
void _openForm(BuildContext context, ShiftsLoaded state) {
    final activeStaff = state.staff.where((member) {
      return member.isActive;
    }).toList();

    final activeBranches = state.branches.where((branch) {
      return branch.isActive;
    }).toList();

    if (activeStaff.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveStaffFound),
      );
      return;
    }

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ShiftsCubit>(),
          child: ShiftFormBottomSheet(
            staff: activeStaff,
            branches: activeBranches,
          ),
        );
      },
    );
  }
}
