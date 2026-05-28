part of 'medication_form_bottom_sheet.dart';

extension MedicationFormBottomSheetStateSaveMedication on _MedicationFormBottomSheetState {
Future<void> _saveMedication() async {
    final state = context.read<MedicationsCubit>().state;

    if (state is MedicationsLoaded && state.isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    final medication = _formController.toMedication();

    final success = _isEditing
        ? await context.read<MedicationsCubit>().updateMedication(medication)
        : await context.read<MedicationsCubit>().createMedication(medication);

    if (!mounted) return;

    if (!success) {
      final currentState = context.read<MedicationsCubit>().state;
      final errorKey = currentState is MedicationsLoaded
          ? currentState.errorMessage
          : null;

      ShowToast.showToastErrorTop(
        message: context.translate(
          medicationErrorLangKey(
            errorKey ?? MedicationErrorKeys.couldNotSave,
          ),
        ),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.medicationUpdatedSuccessfully)
          : context.translate(LangKeys.medicationAddedSuccessfully),
    );

    Navigator.pop(context);
  }
}
