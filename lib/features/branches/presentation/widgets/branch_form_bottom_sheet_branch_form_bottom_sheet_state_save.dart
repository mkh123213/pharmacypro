part of 'branch_form_bottom_sheet.dart';

extension BranchFormBottomSheetStateSave on _BranchFormBottomSheetState {
Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final branch = BranchModel(
      id: widget.branch?.id ?? '',
      name: name.text.trim(),
      address: address.text.trim(),
      city: this._emptyToNull(city.text),
      phone: this._emptyToNull(phone.text),
      email: this._emptyToNull(email.text)?.toLowerCase(),
      managerName: this._emptyToNull(manager.text),
      openingHours: this._emptyToNull(hours.text),
      isActive: isActive,
      createdAt: widget.branch?.createdAt,
      updatedAt: widget.branch?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<BranchesCubit>().updateBranch(branch)
        : await context.read<BranchesCubit>().createBranch(branch);

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
          ? context.translate(LangKeys.branchUpdatedSuccessfully)
          : context.translate(LangKeys.branchAddedSuccessfully),
    );

    Navigator.pop(context);
  }
}
