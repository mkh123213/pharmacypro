part of 'prescriptions_body.dart';

extension PrescriptionsBodyOpenForm on PrescriptionsBody {
void _openForm(BuildContext context, PrescriptionsLoaded state) {
    final activeBranches = state.branches.where((branch) {
      return branch.isActive;
    }).toList();

    final activeMedications = state.medications.where((medication) {
      return medication.isActive;
    }).toList();

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (activeMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PrescriptionsCubit>(),
          child: PrescriptionFormBottomSheet(
            branches: activeBranches,
            medications: activeMedications,
          ),
        );
      },
    );
  }
}
