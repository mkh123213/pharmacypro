part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateAddMedication on _CustomerOrderFormBottomSheetState {
Future<void> addMedication() async {
    final availableMedications = activeMedications;

    if (availableMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    final result = await showSaleMedicationPickerBottomSheet(
      context: context,
      medications: availableMedications,
    );

    if (result == null) return;

    final medication = result.medication;
    final quantity = result.quantity;

    if (quantity <= 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.customerOrderItemInvalidQuantity),
      );
      return;
    }

    final existingIndex = items.indexWhere(
      (item) => item.medicationId == medication.id,
    );

    setState(() {
      if (existingIndex == -1) {
        items.add(
          CustomerOrderItemModel(
            medicationId: medication.id,
            medicationName: medication.name,
            quantity: quantity,
            unitPrice: medication.price,
            total: medication.price * quantity,
          ),
        );
      } else {
        final existing = items[existingIndex];
        final newQuantity = existing.quantity + quantity;

        items[existingIndex] = CustomerOrderItemModel(
          medicationId: existing.medicationId,
          medicationName: existing.medicationName,
          quantity: newQuantity,
          unitPrice: existing.unitPrice,
          total: existing.unitPrice * newQuantity,
        );
      }
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToOrder),
    );
  }
}
