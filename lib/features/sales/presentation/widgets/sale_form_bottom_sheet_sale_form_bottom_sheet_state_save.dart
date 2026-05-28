part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateSave on _SaleFormBottomSheetState {
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

    if (discountAmount > subtotal) {
      ShowToast.showToastErrorTop(
        message: context.translate(
          LangKeys.discountCannotBeGreaterThanSubtotal,
        ),
      );
      return;
    }

    final itemValidationMessage = this._validateSaleItems();

    if (itemValidationMessage != null) {
      ShowToast.showToastErrorTop(message: itemValidationMessage);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = selectedBranch.first;

    final sale = SaleModel(
      id: '',
      branchId: branch.id,
      branchName: branch.name,
      customerName: customer.text.trim().isEmpty ? null : customer.text.trim(),
      customerPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      items: items,
      subtotal: subtotal,
      discount: discountAmount,
      totalAmount: total,
      paymentMethod: payment,
      saleNumber:
          'S-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context.read<SalesCubit>().createSale(sale);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<SalesCubit>().state;

      String message = context.translate(LangKeys.couldNotCompleteSale);

      if (state is SalesLoaded && state.errorMessage != null) {
        message = this._buildSaleErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.saleCompletedSuccessfully),
    );

    Navigator.pop(context);
  }
}
