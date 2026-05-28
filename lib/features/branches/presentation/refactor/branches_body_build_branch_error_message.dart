part of 'branches_body.dart';

String buildBranchErrorMessage(BuildContext context, String errorMessage) {
  if (errorMessage == 'branch_not_found') {
    return context.translate(LangKeys.branchNotFound);
  }

  if (errorMessage == 'branch_name_required') {
    return context.translate(LangKeys.branchNameRequired);
  }

  if (errorMessage == 'branch_address_required') {
    return context.translate(LangKeys.branchAddressRequired);
  }

  if (errorMessage == 'branch_invalid_phone') {
    return context.translate(LangKeys.branchInvalidPhone);
  }

  if (errorMessage == 'branch_invalid_email') {
    return context.translate(LangKeys.branchInvalidEmail);
  }

  if (errorMessage == 'branch_name_already_exists') {
    return context.translate(LangKeys.branchNameAlreadyExists);
  }

  return context.translate(LangKeys.couldNotSaveBranch);
}
