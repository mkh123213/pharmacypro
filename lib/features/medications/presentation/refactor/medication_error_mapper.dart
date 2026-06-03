import '../../../../core/language/lang_keys.dart';

class MedicationErrorKeys {
  const MedicationErrorKeys._();

  static const String notFound = 'medication_not_found';
  static const String nameRequired = 'medication_name_required';
  static const String invalidPrice = 'medication_invalid_price';
  static const String invalidCostPrice = 'medication_invalid_cost_price';
  static const String invalidCategory = 'medication_invalid_category';
  static const String invalidDosageForm = 'medication_invalid_dosage_form';
  static const String invalidImageUrl = 'medication_invalid_image_url';
  static const String duplicateName = 'duplicate_medication_name';
  static const String duplicateBarcode = 'duplicate_medication_barcode';
  static const String couldNotSave = 'could_not_save_medication';
  static const String couldNotLoad = 'could_not_load_medications';
}

String medicationExceptionToErrorKey(Object error) {
  final text = error.toString();

  if (text.contains(MedicationErrorKeys.notFound)) {
    return MedicationErrorKeys.notFound;
  }

  if (text.contains(MedicationErrorKeys.nameRequired)) {
    return MedicationErrorKeys.nameRequired;
  }

  if (text.contains(MedicationErrorKeys.invalidPrice)) {
    return MedicationErrorKeys.invalidPrice;
  }

  if (text.contains(MedicationErrorKeys.invalidCostPrice)) {
    return MedicationErrorKeys.invalidCostPrice;
  }

  if (text.contains(MedicationErrorKeys.invalidCategory)) {
    return MedicationErrorKeys.invalidCategory;
  }

  if (text.contains(MedicationErrorKeys.invalidDosageForm)) {
    return MedicationErrorKeys.invalidDosageForm;
  }

  if (text.contains(MedicationErrorKeys.invalidImageUrl)) {
    return MedicationErrorKeys.invalidImageUrl;
  }

  if (text.contains(MedicationErrorKeys.duplicateName)) {
    return MedicationErrorKeys.duplicateName;
  }

  if (text.contains(MedicationErrorKeys.duplicateBarcode)) {
    return MedicationErrorKeys.duplicateBarcode;
  }

  return MedicationErrorKeys.couldNotSave;
}

String medicationErrorLangKey(String errorKey) {
  switch (errorKey) {
    case MedicationErrorKeys.notFound:
      return LangKeys.medicationNotFoundPlain;
    case MedicationErrorKeys.nameRequired:
      return LangKeys.medicationNameRequired;
    case MedicationErrorKeys.invalidPrice:
      return LangKeys.medicationInvalidPrice;
    case MedicationErrorKeys.invalidCostPrice:
      return LangKeys.medicationInvalidCostPrice;
    case MedicationErrorKeys.invalidCategory:
      return LangKeys.medicationInvalidCategory;
    case MedicationErrorKeys.invalidDosageForm:
      return LangKeys.medicationInvalidDosageForm;
    case MedicationErrorKeys.invalidImageUrl:
      return LangKeys.medicationInvalidImageUrl;
    case MedicationErrorKeys.duplicateName:
      return LangKeys.duplicateMedicationName;
    case MedicationErrorKeys.duplicateBarcode:
      return LangKeys.duplicateMedicationBarcode;
    case MedicationErrorKeys.couldNotLoad:
      return LangKeys.couldNotLoadMedications;
    case MedicationErrorKeys.couldNotSave:
    default:
      return LangKeys.couldNotSaveMedication;
  }
}
