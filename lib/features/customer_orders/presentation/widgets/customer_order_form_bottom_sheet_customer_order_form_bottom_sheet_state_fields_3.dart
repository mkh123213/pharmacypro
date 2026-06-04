part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateFields3 on _CustomerOrderFormBottomSheetState {
  List<Widget> _buildCustomerOrderFormBottomSheetFields3(BuildContext context) {
    final availableBranches = activeBranches;

    return [
                if (activeMedications.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.noActiveMedicationsFound,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
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
                SizedBox(height: 12.h),
                _OrderTotal(total: total),
                SizedBox(height: 14.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createOrder),
                  onPressed: _isSaving || availableBranches.isEmpty
                      ? null
                      : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
