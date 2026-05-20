part of 'inventory_adjust_stock_bottom_sheet.dart';

class _InventoryAdjustStockBottomSheetState
    extends State<InventoryAdjustStockBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantityChange = TextEditingController();
  final reason = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    quantityChange.dispose();
    reason.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final newQuantityPreview =
        widget.item.quantity + (int.tryParse(quantityChange.text.trim()) ?? 0);

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: context.color.border,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 18.h),
                TextApp(
                  text: context.translate(LangKeys.adjustStock),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                TextApp(
                  text: widget.item.medicationName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 4.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.currentQuantity)}: ${widget.item.quantity}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: quantityChange,
                  label: context.translate(LangKeys.adjustmentQuantity),
                  hintText: '-5 or 10',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredNumber(
                    context,
                    fieldName: context.translate(LangKeys.adjustmentQuantity),
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: reason,
                  label: context.translate(LangKeys.adjustmentReason),
                  isRequired: true,
                  maxLines: 3,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.adjustmentReason),
                  ),
                ),
                SizedBox(height: 12.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.newQuantity)}: $newQuantityPreview',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: newQuantityPreview < 0 ? Colors.red : null,
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveAdjustment),
                  onPressed: _isSaving ? null : this._save,
                  isLoading: _isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
