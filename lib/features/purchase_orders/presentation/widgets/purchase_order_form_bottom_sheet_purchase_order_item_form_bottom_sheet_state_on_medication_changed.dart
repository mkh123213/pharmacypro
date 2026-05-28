part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderItemFormBottomSheetStateOnMedicationChanged on _PurchaseOrderItemFormBottomSheetState {
void _onMedicationChanged(String? value) {
    if (value == null) return;

    final medication = widget.medications.firstWhere(
      (item) => item.id == value,
    );

    final cost = medication.costPrice ?? medication.price;

    setState(() {
      medicationId = value;
      unitCost.text = cost.toStringAsFixed(2);
    });
  }
}
