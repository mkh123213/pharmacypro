part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateFields3 on _PurchaseOrderFormBottomSheetState {
  List<Widget> _buildPurchaseOrderFormBottomSheetFields3(BuildContext context) {
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
                  ListView.separated(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, _) => Divider(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = items[index];

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
                              '${context.translate(LangKeys.qty)}: ${item.quantity}'
                              ' · ${context.translate(LangKeys.unitCost)}: \$${item.unitCost.toStringAsFixed(2)}',
                          maxLines: 2,
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
                              onPressed: _canEdit
                                  ? () {
                                      this.removeItem(index);
                                    }
                                  : null,
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                Divider(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: TextApp(
                        text: context.translate(LangKeys.total),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    TextApp(
                      text: '\$${total.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ],
                ),
    ];
  }
}
