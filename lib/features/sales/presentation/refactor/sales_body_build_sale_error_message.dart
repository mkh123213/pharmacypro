part of 'sales_body.dart';

extension SalesBodyBuildSaleErrorMessage on SalesBody {
String _buildSaleErrorMessage(BuildContext context, String errorMessage) {
    if (errorMessage == 'branch_not_found') {
      return context.translate(LangKeys.branchNotFound);
    }

    if (errorMessage == 'inactive_branch') {
      return context.translate(LangKeys.inactiveBranch);
    }

    if (errorMessage == 'sale_missing_branch') {
      return context.translate(LangKeys.saleMissingBranch);
    }

    if (errorMessage == 'sale_has_no_items') {
      return context.translate(LangKeys.saleHasNoItems);
    }

    if (errorMessage == 'sale_invalid_payment_method') {
      return context.translate(LangKeys.saleInvalidPaymentMethod);
    }

    if (errorMessage == 'sale_invalid_subtotal') {
      return context.translate(LangKeys.saleInvalidSubtotal);
    }

    if (errorMessage == 'sale_invalid_discount') {
      return context.translate(LangKeys.saleInvalidDiscount);
    }

    if (errorMessage == 'sale_discount_greater_than_subtotal') {
      return context.translate(LangKeys.discountCannotBeGreaterThanSubtotal);
    }

    if (errorMessage == 'sale_invalid_total') {
      return context.translate(LangKeys.saleInvalidTotal);
    }

    if (errorMessage == 'sale_item_missing_medication') {
      return context.translate(LangKeys.saleItemMissingMedication);
    }

    if (errorMessage == 'sale_item_invalid_quantity') {
      return context.translate(LangKeys.saleItemInvalidQuantity);
    }

    if (errorMessage == 'sale_item_invalid_unit_price') {
      return context.translate(LangKeys.saleItemInvalidUnitPrice);
    }

    if (errorMessage == 'sale_item_invalid_total') {
      return context.translate(LangKeys.saleItemInvalidTotal);
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

    return context.translate(LangKeys.couldNotCompleteSale);
  }
}
