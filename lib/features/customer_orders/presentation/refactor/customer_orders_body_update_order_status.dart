part of 'customer_orders_body.dart';

extension CustomerOrdersBodyUpdateOrderStatus on CustomerOrdersBody {
Future<void> _updateOrderStatus({
    required BuildContext context,
    required String orderId,
    required String nextStatus,
  }) async {
    final success = await context.read<CustomerOrdersCubit>().updateStatus(
      orderId,
      nextStatus,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<CustomerOrdersCubit>().state;

      String message = context.translate(LangKeys.couldNotUpdateOrderStatus);

      if (state is CustomerOrdersLoaded && state.errorMessage != null) {
        message = this._buildCustomerOrderErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.orderStatusUpdatedSuccessfully),
    );
  }
}
