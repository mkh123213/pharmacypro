part of 'supplier_form_bottom_sheet.dart';

extension SupplierFormBottomSheetStateEmptyToNull on _SupplierFormBottomSheetState {
String? _emptyToNull(String value) {
    final text = value.trim();

    if (text.isEmpty) return null;

    return text;
  }
}
