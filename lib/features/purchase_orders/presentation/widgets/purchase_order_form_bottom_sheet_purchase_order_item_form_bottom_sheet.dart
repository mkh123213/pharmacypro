part of 'purchase_order_form_bottom_sheet.dart';

class _PurchaseOrderItemFormBottomSheet extends StatefulWidget {
  const _PurchaseOrderItemFormBottomSheet({required this.medications});

  final List<MedicationModel> medications;

  @override
  State<_PurchaseOrderItemFormBottomSheet> createState() {
    return _PurchaseOrderItemFormBottomSheetState();
  }
}
