part of 'remove_expired_stock_bottom_sheet.dart';

extension RemoveExpiredStockBottomSheetStateSave on _RemoveExpiredStockBottomSheetState {
Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final success = await context
        .read<InventoryAlertsCubit>()
        .removeExpiredStock(item: widget.item, reason: reason.text.trim());

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<InventoryAlertsCubit>().state;

      String message = context.translate(LangKeys.couldNotRemoveExpiredStock);

      if (state is InventoryAlertsLoaded && state.errorMessage != null) {
        message = this._buildErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.expiredStockRemovedSuccessfully),
    );

    Navigator.pop(context);
  }
}
