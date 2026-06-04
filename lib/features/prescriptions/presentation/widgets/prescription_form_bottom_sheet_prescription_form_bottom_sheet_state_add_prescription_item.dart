part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionFormBottomSheetStateAddPrescriptionItem on _PrescriptionFormBottomSheetState {
Future<void> _addPrescriptionItem() async {
    if (widget.medications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    final result = await showPrescriptionItemFormBottomSheet(
      context: context,
      medications: widget.medications,
    );

    if (result == null) return;

    setState(() {
      items.add(result);
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToPrescription),
    );
  }
}
