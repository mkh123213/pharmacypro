part of 'purchase_order_form_bottom_sheet.dart';

extension PurchaseOrderFormBottomSheetStateSave on _PurchaseOrderFormBottomSheetState {
Future<void> save() async {
    if (_isSaving) return;

    if (!_canEdit) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.onlyDraftPurchaseOrdersCanBeEdited),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (widget.suppliers.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveSuppliersFound),
      );
      return;
    }

    if (widget.branches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (supplierId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectSupplierAndBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseAddAtLeastOneItem),
      );
      return;
    }

    final itemValidationMessage = this._validateItemsBeforeSave();

    if (itemValidationMessage != null) {
      ShowToast.showToastErrorTop(message: itemValidationMessage);
      return;
    }

    final dateError = AppValidators.endDateAfterStartDate(
      context,
      startDate: orderDate.text,
      endDate: expectedDelivery.text,
    );

    if (dateError != null) {
      ShowToast.showToastErrorTop(message: dateError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final supplier = widget.suppliers.firstWhere(
      (supplier) => supplier.id == supplierId,
    );

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

    final order = PurchaseOrderModel(
      id: widget.order?.id ?? '',
      supplierId: supplier.id,
      supplierName: supplier.name,
      branchId: branch.id,
      branchName: branch.name,
      status: 'draft',
      orderDate: orderDate.text.trim().isEmpty ? null : orderDate.text.trim(),
      expectedDelivery: expectedDelivery.text.trim().isEmpty
          ? null
          : expectedDelivery.text.trim(),
      totalAmount: total,
      items: items,
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      orderNumber:
          widget.order?.orderNumber ??
          'PO-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      receivedAt: widget.order?.receivedAt,
      createdAt: widget.order?.createdAt,
      updatedAt: widget.order?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<PurchaseOrdersCubit>().updatePurchaseOrder(order)
        : await context.read<PurchaseOrdersCubit>().createPurchaseOrder(order);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(message: this._failureMessage());
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.purchaseOrderUpdatedSuccessfully)
          : context.translate(LangKeys.purchaseOrderCreatedSuccessfully),
    );

    Navigator.pop(context);
  }
}
