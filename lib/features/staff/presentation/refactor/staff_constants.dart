import 'package:flutter/material.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';
import 'package:pharmacypro/core/language/lang_keys.dart';

import '../../../../core/common/widgets/app_status_chip.dart';

const allStaffRolesValue = 'all';

const staffRoles = ['pharmacist', 'technician', 'cashier', 'manager', 'admin'];

const staffRoleOptions = [allStaffRolesValue, ...staffRoles];

String formatStaffRole(BuildContext context, String value) {
  switch (value) {
    case allStaffRolesValue:
      return context.translate(LangKeys.allRoles);
    case 'pharmacist':
      return context.translate(LangKeys.pharmacist);
    case 'technician':
      return context.translate(LangKeys.technician);
    case 'cashier':
      return context.translate(LangKeys.cashier);
    case 'manager':
      return context.translate(LangKeys.manager);
    case 'admin':
      return context.translate(LangKeys.admin);
    default:
      return value;
  }
}

AppStatusChipType roleChipType(String role) {
  switch (role) {
    case 'pharmacist':
      return AppStatusChipType.info;
    case 'technician':
      return AppStatusChipType.primary;
    case 'cashier':
      return AppStatusChipType.success;
    case 'manager':
      return AppStatusChipType.warning;
    case 'admin':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
