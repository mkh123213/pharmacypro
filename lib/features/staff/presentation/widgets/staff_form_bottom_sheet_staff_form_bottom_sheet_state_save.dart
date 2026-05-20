part of 'staff_form_bottom_sheet.dart';

extension StaffFormBottomSheetStateSave on _StaffFormBottomSheetState {
Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final activeBranches = _activeBranches;

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (_branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    final matchingBranches = activeBranches.where((branch) {
      return branch.id == _branchId;
    });

    if (matchingBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveBranch),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final selectedBranch = matchingBranches.first;

    final staff = StaffModel(
      id: widget.staff?.id ?? '',
      fullName: _name.text.trim(),
      email: _email.text.trim().toLowerCase(),
      phone: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
      role: _role,
      branchId: selectedBranch.id,
      branchName: selectedBranch.name,
      licenseNumber: _license.text.trim().isEmpty ? null : _license.text.trim(),
      hireDate: _hireDate.text.trim().isEmpty ? null : _hireDate.text.trim(),
      isActive: _active,
      avatarUrl: widget.staff?.avatarUrl,
      createdAt: widget.staff?.createdAt,
      updatedAt: widget.staff?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<StaffCubit>().updateStaff(staff)
        : await context.read<StaffCubit>().createStaff(staff);

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
          ? context.translate(LangKeys.staffMemberUpdatedSuccessfully)
          : context.translate(LangKeys.staffMemberAddedSuccessfully),
    );

    Navigator.pop(context);
  }
}
