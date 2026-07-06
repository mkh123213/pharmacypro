part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyContent2 on PurchaseOrdersBody {
  List<Widget> _buildPurchaseOrdersContent2(
    BuildContext context,
    dynamic state,
  ) {
    return [
      state.purchaseOrders.isEmpty
          ? AppEmptyState(
              title: context.translate(LangKeys.noPurchaseOrdersFound),
              message:
                  state.searchQuery.trim().isEmpty &&
                      state.selectedStatus == allPurchaseOrderStatusesValue &&
                      state.selectedBranchId == allPurchaseOrderBranchesValue
                  ? context.translate(LangKeys.createYourFirstPurchaseOrder)
                  : context.translate(LangKeys.noPurchaseOrdersMatchYourSearch),
              imagePath: context.assets.noPurchaseOrdersFound,
            )
          : PurchaseOrdersTable(
              orders: state.purchaseOrders,
              isSubmitting: state.isSubmitting,
              onView: (order) {
                showPurchaseOrderDetailsBottomSheet(
                  context,
                  order,
                  onEdit: (selectedOrder) {
                    _openForm(context, state, order: selectedOrder);
                  },
                  onNextStatus: (selectedOrder) {
                    final nextStatus =
                        nextPurchaseOrderStatus[selectedOrder.status];

                    if (nextStatus == null) return;

                    if (nextStatus == 'received') {
                      _confirmReceivePurchaseOrder(context, selectedOrder);
                      return;
                    }

                    _updatePurchaseOrderStatus(
                      context: context,
                      order: selectedOrder,
                      status: nextStatus,
                    );
                  },
                  onCancel: (selectedOrder) {
                    _confirmCancelPurchaseOrder(context, selectedOrder);
                  },
                );
              },
              onEdit: (order) {
                _openForm(context, state, order: order);
              },
              onNextStatus: (order) {
                final nextStatus = nextPurchaseOrderStatus[order.status];

                if (nextStatus == null) return;

                if (nextStatus == 'received') {
                  _confirmReceivePurchaseOrder(context, order);
                  return;
                }

                _updatePurchaseOrderStatus(
                  context: context,
                  order: order,
                  status: nextStatus,
                );
              },
              onCancel: (order) {
                _confirmCancelPurchaseOrder(context, order);
              },
              onDelete: (order) async {
                final confirmed = await showDeleteConfirmationDialog(
                  context: context,
                  title: context.translate(LangKeys.deletePurchaseOrder),
                  message: context.translate(
                    LangKeys.deletePurchaseOrderConfirmation,
                  ),
                );

                if (confirmed != true || !context.mounted) return;

                final success = await context
                    .read<PurchaseOrdersCubit>()
                    .deletePurchaseOrder(order.id);

                if (!context.mounted) return;

                if (success) {
                  ShowToast.showToastSuccessTop(
                    message: context.translate(
                      LangKeys.purchaseOrderDeletedSuccessfully,
                    ),
                  );
                }
              },
            ),
      if (state.isLoadingMore)
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: const Center(child: CircularProgressIndicator()),
        ),
    ];
  }
}
