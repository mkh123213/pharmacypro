part of 'supplier_form_bottom_sheet.dart';

extension SupplierFormBottomSheetStateSave on _SupplierFormBottomSheetState {
Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final supplier = SupplierModel(
      id: widget.supplier?.id ?? '',
      name: name.text.trim(),
      contactPerson: this._emptyToNull(contact.text),
      phone: this._emptyToNull(phone.text),
      email: this._emptyToNull(email.text)?.toLowerCase(),
      address: this._emptyToNull(address.text),
      paymentTerms: this._emptyToNull(paymentTerms.text),
      notes: this._emptyToNull(notes.text),
      isActive: isActive,
      createdAt: widget.supplier?.createdAt,
      updatedAt: widget.supplier?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<SuppliersCubit>().updateSupplier(supplier)
        : await context.read<SuppliersCubit>().createSupplier(supplier);

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
          ? context.translate(LangKeys.supplierUpdatedSuccessfully)
          : context.translate(LangKeys.supplierAddedSuccessfully),
    );

    Navigator.pop(context);
  }
}
