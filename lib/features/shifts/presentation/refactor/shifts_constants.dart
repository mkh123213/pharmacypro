import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

const shiftStatuses = [
  'scheduled',
  'in_progress',
  'completed',
  'absent',
  'cancelled',
];

String shiftStatusLabel(BuildContext context, String value) {
  switch (value) {
    case 'scheduled':
      return context.translate(LangKeys.scheduled);
    case 'in_progress':
      return context.translate(LangKeys.inProgress);
    case 'completed':
      return context.translate(LangKeys.completed);
    case 'absent':
      return context.translate(LangKeys.absent);
    case 'cancelled':
      return context.translate(LangKeys.cancelled);
    default:
      return value;
  }
}

String nextShiftStatus(String status) {
  switch (status) {
    case 'scheduled':
      return 'in_progress';
    case 'in_progress':
      return 'completed';
    default:
      return status;
  }
}
