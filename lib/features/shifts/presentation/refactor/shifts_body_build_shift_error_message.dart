part of 'shifts_body.dart';

String buildShiftErrorMessage(BuildContext context, String errorMessage) {
  if (errorMessage == 'shift_not_found') {
    return context.translate(LangKeys.shiftNotFound);
  }

  if (errorMessage == 'staff_not_found') {
    return context.translate(LangKeys.staffNotFound);
  }

  if (errorMessage == 'inactive_staff') {
    return context.translate(LangKeys.inactiveStaff);
  }

  if (errorMessage == 'branch_not_found') {
    return context.translate(LangKeys.branchNotFound);
  }

  if (errorMessage == 'inactive_branch') {
    return context.translate(LangKeys.inactiveBranch);
  }

  if (errorMessage == 'shift_missing_staff') {
    return context.translate(LangKeys.shiftMissingStaff);
  }

  if (errorMessage == 'shift_missing_branch') {
    return context.translate(LangKeys.shiftMissingBranch);
  }

  if (errorMessage == 'shift_invalid_date') {
    return context.translate(LangKeys.shiftInvalidDate);
  }

  if (errorMessage == 'shift_invalid_time') {
    return context.translate(LangKeys.shiftInvalidTime);
  }

  if (errorMessage == 'shift_end_time_must_be_after_start_time') {
    return context.translate(LangKeys.shiftEndTimeMustBeAfterStartTime);
  }

  if (errorMessage == 'shift_already_completed') {
    return context.translate(LangKeys.shiftAlreadyCompleted);
  }

  if (errorMessage == 'shift_already_cancelled') {
    return context.translate(LangKeys.shiftAlreadyCancelled);
  }

  if (errorMessage == 'cannot_cancel_completed_shift') {
    return context.translate(LangKeys.cannotCancelCompletedShift);
  }

  if (errorMessage == 'invalid_shift_status_transition') {
    return context.translate(LangKeys.invalidShiftStatusTransition);
  }

  return context.translate(LangKeys.couldNotUpdateShiftStatus);
}
