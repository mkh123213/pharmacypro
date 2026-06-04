part of 'customer_orders_body.dart';

extension CustomerOrdersBodyBuildCustomerOrderErrorMessage on CustomerOrdersBody {
String _buildCustomerOrderErrorMessage(
    BuildContext context,
    String errorMessage,
  ) {
    if (errorMessage == 'branch_not_found') {
      return context.translate(LangKeys.branchNotFound);
    }

    if (errorMessage == 'inactive_branch') {
      return context.translate(LangKeys.inactiveBranch);
    }

    if (errorMessage == 'customer_order_customer_name_required') {
      return context.translate(LangKeys.customerOrderCustomerNameRequired);
    }

    if (errorMessage == 'customer_order_missing_branch') {
      return context.translate(LangKeys.customerOrderMissingBranch);
    }

    if (errorMessage == 'customer_order_invalid_type') {
      return context.translate(LangKeys.customerOrderInvalidType);
    }

    if (errorMessage == 'customer_order_invalid_payment_method') {
      return context.translate(LangKeys.customerOrderInvalidPaymentMethod);
    }

    if (errorMessage == 'customer_order_delivery_address_required') {
      return context.translate(LangKeys.customerOrderDeliveryAddressRequired);
    }

    if (errorMessage == 'customer_order_invalid_total') {
      return context.translate(LangKeys.customerOrderInvalidTotal);
    }

    if (errorMessage == 'customer_order_item_missing_medication') {
      return context.translate(LangKeys.customerOrderItemMissingMedication);
    }

    if (errorMessage == 'customer_order_item_invalid_quantity') {
      return context.translate(LangKeys.customerOrderItemInvalidQuantity);
    }

    if (errorMessage == 'customer_order_item_invalid_unit_price') {
      return context.translate(LangKeys.customerOrderItemInvalidUnitPrice);
    }

    if (errorMessage == 'customer_order_item_invalid_total') {
      return context.translate(LangKeys.customerOrderItemInvalidTotal);
    }

    if (errorMessage == 'customer_order_not_found') {
      return context.translate(LangKeys.customerOrderNotFound);
    }

    if (errorMessage == 'customer_order_already_delivered') {
      return context.translate(LangKeys.customerOrderAlreadyDelivered);
    }

    if (errorMessage == 'customer_order_already_cancelled') {
      return context.translate(LangKeys.customerOrderAlreadyCancelled);
    }

    if (errorMessage == 'customer_order_has_no_items') {
      return context.translate(LangKeys.customerOrderHasNoItems);
    }

    if (errorMessage == 'invalid_customer_order_status_transition') {
      return context.translate(LangKeys.invalidCustomerOrderStatusTransition);
    }

    if (errorMessage.startsWith('medication_not_found|')) {
      final medicationName = errorMessage
          .replaceFirst('medication_not_found|', '')
          .trim();

      return context
          .translate(LangKeys.medicationNotFound)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage.startsWith('inactive_medication|')) {
      final medicationName = errorMessage
          .replaceFirst('inactive_medication|', '')
          .trim();

      return context
          .translate(LangKeys.inactiveMedication)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage.startsWith('not_enough_stock_for_medication|')) {
      final medicationName = errorMessage
          .replaceFirst('not_enough_stock_for_medication|', '')
          .trim();

      return context
          .translate(LangKeys.notEnoughStockForMedication)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage.startsWith('expired_stock_for_medication|')) {
      final medicationName = errorMessage
          .replaceFirst('expired_stock_for_medication|', '')
          .trim();

      return context
          .translate(LangKeys.expiredStockForMedication)
          .replaceAll('{medication}', medicationName);
    }

    return context.translate(LangKeys.couldNotUpdateOrderStatus);
  }
}
