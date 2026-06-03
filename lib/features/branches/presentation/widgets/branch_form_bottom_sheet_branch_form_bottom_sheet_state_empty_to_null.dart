part of 'branch_form_bottom_sheet.dart';

extension BranchFormBottomSheetStateEmptyToNull on _BranchFormBottomSheetState {
String? _emptyToNull(String value) {
    final text = value.trim();

    if (text.isEmpty) return null;

    return text;
  }
}
