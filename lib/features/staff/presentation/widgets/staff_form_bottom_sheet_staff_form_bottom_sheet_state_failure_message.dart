part of 'staff_form_bottom_sheet.dart';

extension StaffFormBottomSheetStateFailureMessage on _StaffFormBottomSheetState {
String _failureMessage() {
    final state = context.read<StaffCubit>().state;

    if (state is! StaffLoaded) {
      return context.translate(LangKeys.couldNotSaveStaffMember);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSaveStaffMember);
    }

    if (errorMessage == 'staff_not_found') {
      return context.translate(LangKeys.staffNotFound);
    }

    if (errorMessage == 'staff_name_required') {
      return context.translate(LangKeys.staffNameRequired);
    }

    if (errorMessage == 'staff_email_required') {
      return context.translate(LangKeys.staffEmailRequired);
    }

    if (errorMessage == 'staff_invalid_email') {
      return context.translate(LangKeys.staffInvalidEmail);
    }

    if (errorMessage == 'staff_email_already_exists') {
      return context.translate(LangKeys.staffEmailAlreadyExists);
    }

    if (errorMessage == 'staff_role_required') {
      return context.translate(LangKeys.staffRoleRequired);
    }

    if (errorMessage == 'staff_invalid_role') {
      return context.translate(LangKeys.staffInvalidRole);
    }

    if (errorMessage == 'staff_branch_required') {
      return context.translate(LangKeys.staffBranchRequired);
    }

    if (errorMessage == 'staff_invalid_phone') {
      return context.translate(LangKeys.staffInvalidPhone);
    }

    if (errorMessage == 'staff_invalid_hire_date') {
      return context.translate(LangKeys.staffInvalidHireDate);
    }

    if (errorMessage == 'branch_not_found') {
      return context.translate(LangKeys.branchNotFound);
    }

    if (errorMessage == 'inactive_branch') {
      return context.translate(LangKeys.inactiveBranch);
    }

    return context.translate(LangKeys.couldNotSaveStaffMember);
  }
}
