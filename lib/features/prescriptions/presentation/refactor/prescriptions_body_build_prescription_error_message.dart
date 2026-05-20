part of 'prescriptions_body.dart';

String buildPrescriptionErrorMessage(
  BuildContext context,
  String errorMessage,
) {
  if (errorMessage == 'patient_name_required') {
    return context.translate(LangKeys.patientNameRequired);
  }

  if (errorMessage == 'doctor_name_required') {
    return context.translate(LangKeys.doctorNameRequired);
  }

  if (errorMessage == 'branch_not_found') {
    return context.translate(LangKeys.branchNotFound);
  }

  if (errorMessage == 'inactive_branch') {
    return context.translate(LangKeys.inactiveBranch);
  }

  if (errorMessage == 'prescription_missing_branch') {
    return context.translate(LangKeys.prescriptionMissingBranch);
  }

  if (errorMessage.startsWith('medication_not_found|')) {
    final medicationName = errorMessage
        .replaceFirst('medication_not_found|', '')
        .trim();

    return context
        .translate(LangKeys.medicationNotFound)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('inactive_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('inactive_medication|', '')
        .trim();

    return context
        .translate(LangKeys.inactiveMedication)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('not_enough_stock_for_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('not_enough_stock_for_medication|', '')
        .trim();

    return context
        .translate(LangKeys.notEnoughStockForMedication)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('expired_stock_for_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('expired_stock_for_medication|', '')
        .trim();

    return context
        .translate(LangKeys.expiredStockForMedication)
        .replaceAll('{medication}', medicationName);
  }

  switch (errorMessage) {
    case 'prescription_not_found':
      return context.translate(LangKeys.prescriptionNotFound);
    case 'prescription_already_dispensed':
      return context.translate(LangKeys.prescriptionAlreadyDispensed);
    case 'prescription_already_rejected':
      return context.translate(LangKeys.prescriptionAlreadyRejected);
    case 'prescription_already_expired':
      return context.translate(LangKeys.prescriptionAlreadyExpired);
    case 'prescription_not_verified':
      return context.translate(LangKeys.prescriptionNotVerified);
    case 'invalid_prescription_status_transition':
      return context.translate(LangKeys.invalidPrescriptionStatusTransition);
    case 'prescription_has_no_items':
      return context.translate(LangKeys.prescriptionHasNoItems);
    case 'prescription_item_missing_medication_id':
      return context.translate(LangKeys.prescriptionItemMissingMedicationId);
    case 'prescription_item_invalid_quantity':
      return context.translate(LangKeys.prescriptionItemInvalidQuantity);
    default:
      return context.translate(LangKeys.couldNotUpdatePrescriptionStatus);
  }
}
