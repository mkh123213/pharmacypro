part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateFields1 on _PurchaseOrderFormBottomSheetState {
  List<Widget> _buildPurchaseOrderFormBottomSheetFields1(BuildContext context) {
    return [
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
                  text: _isEditing
                      ? context.translate(LangKeys.editPurchaseOrder)
                      : context.translate(LangKeys.newPurchaseOrder),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                if (!_canEdit) ...[
                  SizedBox(height: 8.h),
                  TextApp(
                    text: context.translate(
                      LangKeys.onlyDraftPurchaseOrdersCanBeEdited,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(color: Colors.red),
                  ),
                ],
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: supplierId,
                  label: context.translate(LangKeys.supplier),
                  isRequired: true,
                  items: widget.suppliers.map((supplier) {
                    return AppDropdownItem<String>(
                      value: supplier.id,
                      label: supplier.name,
                    );
                  }).toList(),
                  onChanged: !_canEdit || widget.suppliers.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            supplierId = value;
                          });
                        },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.supplier),
                  ),
                ),
                if (widget.suppliers.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveSuppliersFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
    ];
  }
}
