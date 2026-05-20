part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyContent2 on PurchaseOrdersBody {
  List<Widget> _buildPurchaseOrdersContent2(BuildContext context, dynamic state) {
    return [
                  state.purchaseOrders.isEmpty
                      ? AppEmptyState(
                          title: context.translate(
                            LangKeys.noPurchaseOrdersFound,
                          ),
                          message:
                              state.searchQuery.trim().isEmpty &&
                                  state.selectedStatus ==
                                      allPurchaseOrderStatusesValue &&
                                  state.selectedBranchId ==
                                      allPurchaseOrderBranchesValue
                              ? context.translate(
                                  LangKeys.createYourFirstPurchaseOrder,
                                )
                              : context.translate(
                                  LangKeys.noPurchaseOrdersMatchYourSearch,
                                ),
                          icon: Icons.receipt_long_outlined,
                        )
                      : PurchaseOrdersTable(
                          orders: state.purchaseOrders,
                          isSubmitting: state.isSubmitting,
                          onView: (order) {
                            showPurchaseOrderDetailsBottomSheet(
                              context,
                              order,
                              onEdit: (selectedOrder) {
                                this._openForm(context, state, order: selectedOrder);
                              },
                              onNextStatus: (selectedOrder) {
                                final nextStatus =
                                    nextPurchaseOrderStatus[selectedOrder
                                        .status];

                                if (nextStatus == null) return;

                                if (nextStatus == 'received') {
                                  this._confirmReceivePurchaseOrder(
                                    context,
                                    selectedOrder,
                                  );
                                  return;
                                }

                                this._updatePurchaseOrderStatus(
                                  context: context,
                                  order: selectedOrder,
                                  status: nextStatus,
                                );
                              },
                              onCancel: (selectedOrder) {
                                this._confirmCancelPurchaseOrder(
                                  context,
                                  selectedOrder,
                                );
                              },
                            );
                          },
                          onEdit: (order) {
                            this._openForm(context, state, order: order);
                          },
                          onNextStatus: (order) {
                            final nextStatus =
                                nextPurchaseOrderStatus[order.status];

                            if (nextStatus == null) return;

                            if (nextStatus == 'received') {
                              this._confirmReceivePurchaseOrder(context, order);
                              return;
                            }

                            this._updatePurchaseOrderStatus(
                              context: context,
                              order: order,
                              status: nextStatus,
                            );
                          },
                          onCancel: (order) {
                            this._confirmCancelPurchaseOrder(context, order);
                          },
                        ),
    ];
  }
}
