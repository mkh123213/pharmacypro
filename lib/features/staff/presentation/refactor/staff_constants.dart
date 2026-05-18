import '../../../../core/common/widgets/app_status_chip.dart';

const allStaffRolesValue = 'all';
const staffRoles = ['pharmacist', 'technician', 'cashier', 'manager', 'admin'];
const staffRoleOptions = [allStaffRolesValue, ...staffRoles];

String formatStaffRole(String value) {
  if (value == allStaffRolesValue) return 'All Roles';
  return value.split('_').map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1)).join(' ');
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
