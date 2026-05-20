part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateFields4 on _PurchaseOrderFormBottomSheetState {
  List<Widget> _buildPurchaseOrderFormBottomSheetFields4(BuildContext context) {
    return [
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: _isEditing
                      ? context.translate(LangKeys.updatePurchaseOrder)
                      : context.translate(LangKeys.createPurchaseOrder),
                  onPressed: _isSaving || !_canEdit ? null : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
