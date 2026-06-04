part of 'medication_form_bottom_sheet.dart';

extension MedicationFormBottomSheetStateFields3 on _MedicationFormBottomSheetState {
  List<Widget> _buildMedicationFormBottomSheetFields3(BuildContext context) {
    final state = context.watch<MedicationsCubit>().state;
    final isSubmitting = state is MedicationsLoaded && state.isSubmitting;

    return [
                AppSwitchField(
                  value: _formController.requiresPrescription,
                  title: context.translate(LangKeys.requiresPrescription),
                  onChanged: (value) {
                    setState(() {
                      _formController.requiresPrescription = value;
                    });
                  },
                ),
                AppSwitchField(
                  value: _formController.isActive,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      _formController.isActive = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveMedication),
                  onPressed: isSubmitting ? null : this._saveMedication,
                  isLoading: isSubmitting,
                ),
    ];
  }
}
