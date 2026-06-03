part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateFields3 on _SaleFormBottomSheetState {
  List<Widget> _buildSaleFormBottomSheetFields3(BuildContext context) {
    final availableBranches = activeBranches;

    return [
                if (items.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: TextApp(
                      text: context.translate(LangKeys.noItemsAdded),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  )
                else
                  ...items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: TextApp(
                        text: item.medicationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                      subtitle: TextApp(
                        text:
                            '${item.quantity} x \$${item.unitPrice.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextApp(
                            text: '\$${item.total.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                          IconButton(
                            onPressed: () {
                              this.removeItem(index);
                            },
                            icon: Icon(Icons.close, size: 18.sp),
                          ),
                        ],
                      ),
                    );
                  }),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: discount,
                  label: context.translate(LangKeys.discount),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.optionalNonNegativeNumber(context),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 12.h),
                SaleSummaryCard(
                  subtotal: subtotal,
                  discount: discountAmount,
                  total: total,
                ),
                SizedBox(height: 12.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.completeSale),
                  onPressed: _isSaving || availableBranches.isEmpty
                      ? null
                      : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
