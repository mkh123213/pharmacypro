import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

const allShiftStatusesValue = 'all';
const allShiftBranchesValue = 'all';
const allShiftStaffValue = 'all';

const shiftStatuses = [
  allShiftStatusesValue,
  'scheduled',
  'in_progress',
  'completed',
  'cancelled',
];

String shiftStatusLabel(BuildContext context, String value) {
  switch (value) {
    case allShiftStatusesValue:
      return context.translate(LangKeys.allStatuses);
    case 'scheduled':
      return context.translate(LangKeys.scheduled);
    case 'in_progress':
      return context.translate(LangKeys.inProgress);
    case 'completed':
      return context.translate(LangKeys.completed);
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

bool canCancelShift(String status) {
  return status != 'completed' && status != 'cancelled';
}

bool canMoveShiftNext(String status) {
  return nextShiftStatus(status) != status;
}

AppStatusChipType shiftStatusType(String status) {
  switch (status) {
    case 'scheduled':
      return AppStatusChipType.info;
    case 'in_progress':
      return AppStatusChipType.warning;
    case 'completed':
      return AppStatusChipType.success;
    case 'cancelled':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
