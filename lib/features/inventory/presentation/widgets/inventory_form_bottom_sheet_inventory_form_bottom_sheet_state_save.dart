part of 'inventory_form_bottom_sheet.dart';

extension InventoryFormBottomSheetStateSave on _InventoryFormBottomSheetState {
Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (activeMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (medicationId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedicationAndBranch),
      );
      return;
    }

    final selectedMedication = activeMedications.where(
      (item) => item.id == medicationId,
    );

    final selectedBranch = activeBranches.where((item) => item.id == branchId);

    if (selectedMedication.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveMedicationPlain),
      );
      return;
    }

    if (selectedBranch.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveBranch),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final medication = selectedMedication.first;
    final branch = selectedBranch.first;

    final model = InventoryModel(
      id: widget.item?.id ?? '',
      medicationId: medication.id,
      medicationName: medication.name,
      branchId: branch.id,
      branchName: branch.name,
      quantity: _isEditing
          ? widget.item!.quantity
          : int.tryParse(quantity.text.trim()) ?? -1,
      minStockLevel: int.tryParse(min.text.trim()) ?? -1,
      batchNumber: batch.text.trim().isEmpty ? null : batch.text.trim(),
      expiryDate: expiry.text.trim().isEmpty ? null : expiry.text.trim(),
      locationInStore: location.text.trim().isEmpty
          ? null
          : location.text.trim(),
      createdAt: widget.item?.createdAt,
      updatedAt: widget.item?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<InventoryCubit>().updateInventory(model)
        : await context.read<InventoryCubit>().createInventory(model);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<InventoryCubit>().state;

      String message = context.translate(LangKeys.couldNotSaveInventoryItem);

      if (state is InventoryLoaded && state.errorMessage != null) {
        message = this._buildInventoryErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.inventoryItemUpdatedSuccessfully)
          : context.translate(LangKeys.inventoryItemAddedSuccessfully),
    );

    if (model.quantity <= model.minStockLevel) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.itemBelowMinimumStockLevel),
      );
    }

    Navigator.pop(context);
  }
}
