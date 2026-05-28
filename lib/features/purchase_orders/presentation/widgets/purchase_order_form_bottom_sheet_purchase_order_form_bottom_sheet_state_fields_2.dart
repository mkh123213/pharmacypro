part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateFields2 on _PurchaseOrderFormBottomSheetState {
  List<Widget> _buildPurchaseOrderFormBottomSheetFields2(BuildContext context) {
    return [
                AppDropdownField<String>(
                  value: branchId,
                  label: context.translate(LangKeys.branch),
                  isRequired: true,
                  items: widget.branches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: !_canEdit || widget.branches.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            branchId = value;
                          });
                        },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                if (widget.branches.isEmpty) ...[
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
                AppDateField(
                  controller: orderDate,
                  label: context.translate(LangKeys.orderDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expectedDelivery,
                  label: context.translate(LangKeys.expectedDelivery),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: TextApp(
                        text: context.translate(LangKeys.items),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: _canEdit ? addPurchaseOrderItem : null,
                      icon: const Icon(Icons.add),
                      label: TextApp(
                        text: context.translate(LangKeys.add),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                  ],
                ),
    ];
  }
}
