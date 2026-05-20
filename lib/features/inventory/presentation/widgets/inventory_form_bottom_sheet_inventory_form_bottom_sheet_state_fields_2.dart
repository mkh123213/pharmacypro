part of 'inventory_form_bottom_sheet.dart';

extension InventoryFormBottomSheetStateFields2 on _InventoryFormBottomSheetState {
  List<Widget> _buildInventoryFormBottomSheetFields2(BuildContext context) {
    final branches = activeBranches;

    return [
                if (branches.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveBranchesFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppTextField(
                  controller: quantity,
                  label: context.translate(LangKeys.quantity),
                  isRequired: !_isEditing,
                  readOnly: _isEditing,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  suffixIcon: _isEditing
                      ? Tooltip(
                          message: context.translate(
                            LangKeys.useAdjustStockToChangeQuantity,
                          ),
                          child: const Icon(Icons.lock_outline),
                        )
                      : null,
                  validator: _isEditing
                      ? null
                      : AppValidators.requiredNonNegativeNumber(
                          context,
                          fieldName: context.translate(LangKeys.quantity),
                        ),
                ),
                if (_isEditing) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.useAdjustStockToChangeQuantity,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: context.color.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppTextField(
                  controller: min,
                  label: context.translate(LangKeys.minStockLevel),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredNonNegativeNumber(
                    context,
                    fieldName: context.translate(LangKeys.minStockLevel),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: batch,
                  label: context.translate(LangKeys.batchNumber),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expiry,
                  label: context.translate(LangKeys.expiryDate),
                  validator: AppValidators.optionalDate(context),
                ),
    ];
  }
}
