part of 'inventory_adjust_stock_bottom_sheet.dart';

extension InventoryAdjustStockBottomSheetStateSave on _InventoryAdjustStockBottomSheetState {
Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final change = int.tryParse(quantityChange.text.trim()) ?? 0;

    if (change == 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.adjustmentQuantityCannotBeZero),
      );
      return;
    }

    if (widget.item.quantity + change < 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.quantityCannotGoBelowZero),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final success = await context.read<InventoryCubit>().adjustInventoryStock(
      item: widget.item,
      quantityChange: change,
      reason: reason.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<InventoryCubit>().state;

      String message = context.translate(LangKeys.couldNotAdjustStock);

      if (state is InventoryLoaded && state.errorMessage != null) {
        message = this._buildErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.stockAdjustedSuccessfully),
    );

    Navigator.pop(context);
  }
}
