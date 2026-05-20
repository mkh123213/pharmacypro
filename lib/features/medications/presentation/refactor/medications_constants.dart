import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import 'medication_filter_values.dart';

export 'medication_filter_values.dart';

String medicationCategoryLabel(BuildContext context, String value) {
  switch (value) {
    case allMedicationCategoriesValue:
      return context.translate(LangKeys.allCategories);
    case 'analgesic':
      return context.translate(LangKeys.analgesic);
    case 'antibiotic':
      return context.translate(LangKeys.antibiotic);
    case 'antiviral':
      return context.translate(LangKeys.antiviral);
    case 'antifungal':
      return context.translate(LangKeys.antifungal);
    case 'cardiovascular':
      return context.translate(LangKeys.cardiovascular);
    case 'diabetes':
      return context.translate(LangKeys.diabetes);
    case 'respiratory':
      return context.translate(LangKeys.respiratory);
    case 'gastrointestinal':
      return context.translate(LangKeys.gastrointestinal);
    case 'dermatology':
      return context.translate(LangKeys.dermatology);
    case 'vitamins_supplements':
      return context.translate(LangKeys.vitaminsSupplements);
    case 'otc':
      return context.translate(LangKeys.otc);
    case 'other':
      return context.translate(LangKeys.other);
    default:
      return value;
  }
}

String medicationFormLabel(BuildContext context, String value) {
  switch (value) {
    case 'tablet':
      return context.translate(LangKeys.tablet);
    case 'capsule':
      return context.translate(LangKeys.capsule);
    case 'syrup':
      return context.translate(LangKeys.syrup);
    case 'injection':
      return context.translate(LangKeys.injection);
    case 'cream':
      return context.translate(LangKeys.cream);
    case 'drops':
      return context.translate(LangKeys.drops);
    case 'inhaler':
      return context.translate(LangKeys.inhaler);
    case 'patch':
      return context.translate(LangKeys.patch);
    case 'suppository':
      return context.translate(LangKeys.suppository);
    case 'other':
      return context.translate(LangKeys.other);
    default:
      return value;
  }
}

String medicationStatusLabel(BuildContext context, String value) {
  switch (value) {
    case allMedicationStatusesValue:
      return context.translate(LangKeys.allStatuses);
    case activeMedicationStatusValue:
      return context.translate(LangKeys.active);
    case inactiveMedicationStatusValue:
      return context.translate(LangKeys.inactive);
    default:
      return value;
  }
}
