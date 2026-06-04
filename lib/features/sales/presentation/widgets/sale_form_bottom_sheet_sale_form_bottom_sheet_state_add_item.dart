part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateAddItem on _SaleFormBottomSheetState {

void _scanBarcodeToAddItem(BuildContext context) {
    var hasScanned = false;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: TextApp(
            text: context.translate(LangKeys.scanToAddItem),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: 320,
            height: 320,
            child: MobileScanner(
              onDetect: (capture) {
                if (hasScanned) return;
                if (capture.barcodes.isEmpty) return;

                final code = capture.barcodes.first.rawValue;
                if (code == null || code.isEmpty) return;

                hasScanned = true;
                Navigator.pop(dialogContext);

                _addItemByBarcode(code);
              },
            ),
          ),
        );
      },
    );
  }

  void _addItemByBarcode(String barcode) {
    final medication = activeMedications.where((m) {
      return m.barcode != null &&
          m.barcode!.toLowerCase().trim() == barcode.toLowerCase().trim();
    }).toList();

    if (medication.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.medicationNotInInventory),
      );
      return;
    }

    final med = medication.first;

    final existingIndex = items.indexWhere(
      (item) => item.medicationId == med.id,
    );

    setState(() {
      if (existingIndex == -1) {
        items.add(
          SaleItemModel(
            medicationId: med.id,
            medicationName: med.name,
            quantity: 1,
            unitPrice: med.price,
            total: med.price,
          ),
        );
      } else {
        final existing = items[existingIndex];
        final newQuantity = existing.quantity + 1;

        items[existingIndex] = SaleItemModel(
          medicationId: existing.medicationId,
          medicationName: existing.medicationName,
          quantity: newQuantity,
          unitPrice: existing.unitPrice,
          total: existing.unitPrice * newQuantity,
        );
      }
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.itemAddedViaScan),
    );
  }

Future<void> addItem() async {
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
        message: context.translate(LangKeys.saleItemInvalidQuantity),
      );
      return;
    }

    final existingIndex = items.indexWhere(
      (item) => item.medicationId == medication.id,
    );

    setState(() {
      if (existingIndex == -1) {
        items.add(
          SaleItemModel(
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

        items[existingIndex] = SaleItemModel(
          medicationId: existing.medicationId,
          medicationName: existing.medicationName,
          quantity: newQuantity,
          unitPrice: existing.unitPrice,
          total: existing.unitPrice * newQuantity,
        );
      }
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToSale),
    );
  }
}
