part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionFormBottomSheetStateRemovePrescriptionItem on _PrescriptionFormBottomSheetState {
void _removePrescriptionItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
