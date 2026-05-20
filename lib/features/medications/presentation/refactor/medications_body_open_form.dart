part of 'medications_body.dart';

extension MedicationsBodyOpenForm on MedicationsBody {
void _openForm(BuildContext context, {MedicationModel? medication}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MedicationsCubit>(),
          child: MedicationFormBottomSheet(medication: medication),
        );
      },
    );
  }
}
