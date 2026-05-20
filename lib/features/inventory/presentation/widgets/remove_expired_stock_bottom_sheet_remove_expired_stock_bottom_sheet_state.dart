part of 'remove_expired_stock_bottom_sheet.dart';

class _RemoveExpiredStockBottomSheetState
    extends State<RemoveExpiredStockBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final reason = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

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
                  text: context.translate(LangKeys.removeExpiredStock),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14.h),
                TextApp(
                  text: widget.item.medicationName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.currentQuantity)}: ${widget.item.quantity}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.expiryDate)}: ${widget.item.expiryDate ?? '—'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: reason,
                  label: context.translate(LangKeys.removalReason),
                  isRequired: true,
                  maxLines: 3,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.removalReason),
                  ),
                ),
                SizedBox(height: 14.h),
                TextApp(
                  text: context
                      .translate(LangKeys.removeExpiredStockWarning)
                      .replaceAll(
                        '{quantity}',
                        widget.item.quantity.toString(),
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.confirmRemoval),
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
