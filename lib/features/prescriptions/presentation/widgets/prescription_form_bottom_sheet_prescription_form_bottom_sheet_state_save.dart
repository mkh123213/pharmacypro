part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionFormBottomSheetStateSave on _PrescriptionFormBottomSheetState {
Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(
          LangKeys.pleaseAddAtLeastOnePrescriptionItem,
        ),
      );
      return;
    }

    final dateError = AppValidators.endDateAfterStartDate(
      context,
      startDate: issueDate.text,
      endDate: expiryDate.text,
    );

    if (dateError != null) {
      ShowToast.showToastErrorTop(message: dateError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

    final prescription = PrescriptionModel(
      id: '',
      patientName: patient.text.trim(),
      patientPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      doctorName: doctor.text.trim(),
      doctorLicense: license.text.trim().isEmpty ? null : license.text.trim(),
      issueDate: issueDate.text.trim().isEmpty ? null : issueDate.text.trim(),
      expiryDate: expiryDate.text.trim().isEmpty
          ? null
          : expiryDate.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      items: items,
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      prescriptionNumber:
          'RX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context.read<PrescriptionsCubit>().createPrescription(
      prescription,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<PrescriptionsCubit>().state;

      String message = context.translate(LangKeys.couldNotSavePrescription);

      if (state is PrescriptionsLoaded && state.errorMessage != null) {
        message = buildPrescriptionErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.prescriptionCreatedSuccessfully),
    );

    Navigator.pop(context);
  }
}
