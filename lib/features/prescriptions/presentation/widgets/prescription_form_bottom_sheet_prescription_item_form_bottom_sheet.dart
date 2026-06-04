part of 'prescription_form_bottom_sheet.dart';

class _PrescriptionItemFormBottomSheet extends StatefulWidget {
  const _PrescriptionItemFormBottomSheet({required this.medications});

  final List<MedicationModel> medications;

  @override
  State<_PrescriptionItemFormBottomSheet> createState() {
    return _PrescriptionItemFormBottomSheetState();
  }
}
