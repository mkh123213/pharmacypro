part of 'inventory_form_bottom_sheet.dart';

extension InventoryFormBottomSheetStateFields3 on _InventoryFormBottomSheetState {
  List<Widget> _buildInventoryFormBottomSheetFields3(BuildContext context) {
    return [
                SizedBox(height: 10.h),
                AppTextField(
                  controller: location,
                  label: context.translate(LangKeys.locationInStore),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveInventoryItem),
                  onPressed: _isSaving ? null : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
