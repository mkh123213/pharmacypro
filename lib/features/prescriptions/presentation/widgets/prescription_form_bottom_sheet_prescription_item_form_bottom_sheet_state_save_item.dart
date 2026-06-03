part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionItemFormBottomSheetStateSaveItem on _PrescriptionItemFormBottomSheetState {
void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    if (medicationId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedication),
      );
      return;
    }

    final medication = widget.medications.firstWhere(
      (item) => item.id == medicationId,
    );

    final item = PrescriptionItemModel(
      medicationId: medication.id,
      medicationName: medication.name,
      quantity: int.tryParse(quantity.text.trim()) ?? 1,
      dosage: dosage.text.trim().isEmpty ? null : dosage.text.trim(),
      instructions: instructions.text.trim().isEmpty
          ? null
          : instructions.text.trim(),
    );

    Navigator.pop(context, item);
  }
}
