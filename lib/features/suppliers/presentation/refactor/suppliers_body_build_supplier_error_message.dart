part of 'suppliers_body.dart';

String buildSupplierErrorMessage(BuildContext context, String errorMessage) {
  if (errorMessage == 'supplier_not_found') {
    return context.translate(LangKeys.supplierNotFound);
  }

  if (errorMessage == 'supplier_name_required') {
    return context.translate(LangKeys.supplierNameRequired);
  }

  if (errorMessage == 'supplier_invalid_phone') {
    return context.translate(LangKeys.supplierInvalidPhone);
  }

  if (errorMessage == 'supplier_invalid_email') {
    return context.translate(LangKeys.supplierInvalidEmail);
  }

  if (errorMessage == 'supplier_name_already_exists') {
    return context.translate(LangKeys.supplierNameAlreadyExists);
  }

  if (errorMessage == 'supplier_email_already_exists') {
    return context.translate(LangKeys.supplierEmailAlreadyExists);
  }

  return context.translate(LangKeys.couldNotSaveSupplier);
}
