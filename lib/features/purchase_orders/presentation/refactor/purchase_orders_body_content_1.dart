part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyContent1 on PurchaseOrdersBody {
  List<Widget> _buildPurchaseOrdersContent1(BuildContext context, dynamic state) {
    return [
                  AppPageHeader(
                    title: context.translate(LangKeys.purchaseOrders),
                    subtitle: context.translate(
                      LangKeys.manageSupplierPurchaseOrders,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.newOrder),
                      icon: Icons.add,
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              this._openForm(context, state);
                            },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _PurchaseOrderFilters(state: state),
                  SizedBox(height: 14.h),
                  _PurchaseOrderSummaryCards(orders: state.purchaseOrders),
                  SizedBox(height: 14.h),
    ];
  }
}
