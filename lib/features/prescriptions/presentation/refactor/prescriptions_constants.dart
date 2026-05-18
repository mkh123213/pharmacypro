import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

const allPrescriptionStatusesValue = 'all';

const prescriptionStatuses = [
  allPrescriptionStatusesValue,
  'pending',
  'verified',
  'dispensed',
  'rejected',
  'expired',
];

String prescriptionStatusLabel(BuildContext context, String value) {
  switch (value) {
    case allPrescriptionStatusesValue:
      return context.translate(LangKeys.allStatuses);
    case 'pending':
      return context.translate(LangKeys.pending);
    case 'verified':
      return context.translate(LangKeys.verified);
    case 'dispensed':
      return context.translate(LangKeys.dispensed);
    case 'rejected':
      return context.translate(LangKeys.rejected);
    case 'expired':
      return context.translate(LangKeys.expired);
    default:
      return value;
  }
}
