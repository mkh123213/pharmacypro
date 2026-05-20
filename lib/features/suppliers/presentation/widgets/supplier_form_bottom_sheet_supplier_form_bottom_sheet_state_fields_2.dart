part of 'supplier_form_bottom_sheet.dart';

extension SupplierFormBottomSheetStateFields2 on _SupplierFormBottomSheetState {
  List<Widget> _buildSupplierFormBottomSheetFields2(BuildContext context) {
    return [
                AppSwitchField(
                  value: isActive,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveSupplier),
                  onPressed: _isSaving ? null : this._save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
