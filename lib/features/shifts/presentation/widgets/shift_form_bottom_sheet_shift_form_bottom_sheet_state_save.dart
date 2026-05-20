part of 'shift_form_bottom_sheet.dart';

extension ShiftFormBottomSheetStateSave on _ShiftFormBottomSheetState {
Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (widget.staff.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveStaffFound),
      );
      return;
    }

    if (widget.branches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (staffId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectStaffAndBranch),
      );
      return;
    }

    final timeError = AppValidators.endTimeAfterStartTime(
      context,
      startTime: start.text,
      endTime: end.text,
    );

    if (timeError != null) {
      ShowToast.showToastErrorTop(message: timeError);
      return;
    }

    final selectedStaff = widget.staff.where((item) => item.id == staffId);
    final selectedBranch = widget.branches.where((item) => item.id == branchId);

    if (selectedStaff.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveStaff),
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

    final member = selectedStaff.first;
    final branch = selectedBranch.first;

    final shift = ShiftModel(
      id: '',
      staffId: member.id,
      staffName: member.fullName,
      branchId: branch.id,
      branchName: branch.name,
      date: date.text.trim(),
      startTime: start.text.trim(),
      endTime: end.text.trim(),
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
    );

    final success = await context.read<ShiftsCubit>().createShift(shift);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(message: this._failureMessage());
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.shiftScheduledSuccessfully),
    );

    Navigator.pop(context);
  }
}
