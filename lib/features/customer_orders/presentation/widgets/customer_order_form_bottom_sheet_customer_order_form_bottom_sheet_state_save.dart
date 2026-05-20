part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateSave on _CustomerOrderFormBottomSheetState {
Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    final selectedBranch = activeBranches.where(
      (branch) => branch.id == branchId,
    );

    if (selectedBranch.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseAddAtLeastOneItem),
      );
      return;
    }

    if (orderType == 'delivery' && address.text.trim().isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseEnterDeliveryAddress),
      );
      return;
    }

    final itemValidationMessage = this._validateItems();

    if (itemValidationMessage != null) {
      ShowToast.showToastErrorTop(message: itemValidationMessage);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = selectedBranch.first;

    final order = CustomerOrderModel(
      id: '',
      customerName: name.text.trim(),
      customerPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      deliveryAddress: orderType == 'delivery' ? address.text.trim() : null,
      orderType: orderType,
      paymentMethod: paymentMethod,
      items: items,
      totalAmount: total,
      orderNumber:
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context
        .read<CustomerOrdersCubit>()
        .createCustomerOrder(order);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<CustomerOrdersCubit>().state;

      String message = context.translate(LangKeys.couldNotCreateOrder);

      if (state is CustomerOrdersLoaded && state.errorMessage != null) {
        message = this._buildCustomerOrderErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.orderCreatedSuccessfully),
    );

    Navigator.pop(context);
  }
}
