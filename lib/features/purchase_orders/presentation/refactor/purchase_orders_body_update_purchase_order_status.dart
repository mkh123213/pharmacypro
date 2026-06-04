part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyUpdatePurchaseOrderStatus on PurchaseOrdersBody {
Future<void> _updatePurchaseOrderStatus({
    required BuildContext context,
    required PurchaseOrderModel order,
    required String status,
  }) async {
    final success = await context.read<PurchaseOrdersCubit>().updateStatus(
      order.id,
      status,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<PurchaseOrdersCubit>().state;

      String message = context.translate(
        LangKeys.couldNotUpdatePurchaseOrderStatus,
      );

      if (state is PurchaseOrdersLoaded && state.errorMessage != null) {
        message = buildPurchaseOrderErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    String message;

    switch (status) {
      case 'sent':
        message = context.translate(LangKeys.purchaseOrderSentSuccessfully);
        break;
      case 'confirmed':
        message = context.translate(
          LangKeys.purchaseOrderConfirmedSuccessfully,
        );
        break;
      case 'received':
        message = context.translate(LangKeys.purchaseOrderReceivedSuccessfully);
        break;
      case 'cancelled':
        message = context.translate(LangKeys.purchaseOrderCancelled);
        break;
      default:
        message = context.translate(
          LangKeys.purchaseOrderStatusUpdatedSuccessfully,
        );
    }

    ShowToast.showToastSuccessTop(message: message);
  }
}
