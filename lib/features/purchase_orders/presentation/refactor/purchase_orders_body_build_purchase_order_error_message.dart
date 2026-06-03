part of 'purchase_orders_body.dart';

String buildPurchaseOrderErrorMessage(
  BuildContext context,
  String errorMessage,
) {
  if (errorMessage == 'supplier_not_found') {
    return context.translate(LangKeys.supplierNotFound);
  }

  if (errorMessage == 'inactive_supplier') {
    return context.translate(LangKeys.inactiveSupplier);
  }

  if (errorMessage == 'branch_not_found') {
    return context.translate(LangKeys.branchNotFound);
  }

  if (errorMessage == 'inactive_branch') {
    return context.translate(LangKeys.inactiveBranch);
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

  if (errorMessage == 'purchase_order_not_found') {
    return context.translate(LangKeys.purchaseOrderNotFound);
  }

  if (errorMessage == 'purchase_order_already_received') {
    return context.translate(LangKeys.purchaseOrderAlreadyReceived);
  }

  if (errorMessage == 'purchase_order_already_cancelled') {
    return context.translate(LangKeys.purchaseOrderAlreadyCancelled);
  }

  if (errorMessage == 'cannot_cancel_received_purchase_order') {
    return context.translate(LangKeys.cannotCancelReceivedPurchaseOrder);
  }

  if (errorMessage == 'invalid_purchase_order_status_transition') {
    return context.translate(LangKeys.invalidPurchaseOrderStatusTransition);
  }

  if (errorMessage == 'only_draft_purchase_orders_can_be_edited') {
    return context.translate(LangKeys.onlyDraftPurchaseOrdersCanBeEdited);
  }

  if (errorMessage == 'purchase_order_has_no_items') {
    return context.translate(LangKeys.purchaseOrderHasNoItems);
  }

  if (errorMessage == 'purchase_order_item_missing_medication') {
    return context.translate(LangKeys.purchaseOrderItemMissingMedication);
  }

  if (errorMessage == 'purchase_order_item_invalid_quantity') {
    return context.translate(LangKeys.purchaseOrderItemInvalidQuantity);
  }

  if (errorMessage == 'purchase_order_item_invalid_unit_cost') {
    return context.translate(LangKeys.purchaseOrderItemInvalidUnitCost);
  }

  if (errorMessage == 'purchase_order_item_invalid_total') {
    return context.translate(LangKeys.purchaseOrderItemInvalidTotal);
  }

  if (errorMessage == 'purchase_order_invalid_total') {
    return context.translate(LangKeys.purchaseOrderInvalidTotal);
  }

  return context.translate(LangKeys.couldNotUpdatePurchaseOrderStatus);
}
