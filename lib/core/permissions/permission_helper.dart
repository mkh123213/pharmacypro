import '../routing/app_routes.dart';

class PermissionHelper {
  PermissionHelper._();

  static const _roleRoutes = <String, Set<String>>{
    'admin': {
      AppRoutes.dashboard,
      AppRoutes.inventory,
      AppRoutes.medications,
      AppRoutes.sales,
      AppRoutes.prescriptions,
      AppRoutes.orders,
      AppRoutes.suppliers,
      AppRoutes.purchaseOrders,
      AppRoutes.staff,
      AppRoutes.shifts,
      AppRoutes.branches,
      AppRoutes.reports,
      AppRoutes.stockHistory,
      AppRoutes.inventoryAlerts,
    },
    'manager': {
      AppRoutes.dashboard,
      AppRoutes.inventory,
      AppRoutes.medications,
      AppRoutes.sales,
      AppRoutes.prescriptions,
      AppRoutes.orders,
      AppRoutes.suppliers,
      AppRoutes.purchaseOrders,
      AppRoutes.shifts,
      AppRoutes.branches,
      AppRoutes.reports,
      AppRoutes.stockHistory,
      AppRoutes.inventoryAlerts,
    },
    'pharmacist': {
      AppRoutes.dashboard,
      AppRoutes.inventory,
      AppRoutes.medications,
      AppRoutes.sales,
      AppRoutes.prescriptions,
      AppRoutes.orders,
      AppRoutes.reports,
      AppRoutes.stockHistory,
      AppRoutes.inventoryAlerts,
    },
    'technician': {
      AppRoutes.dashboard,
      AppRoutes.inventory,
      AppRoutes.medications,
      AppRoutes.stockHistory,
      AppRoutes.inventoryAlerts,
    },
    'cashier': {
      AppRoutes.dashboard,
      AppRoutes.sales,
      AppRoutes.orders,
    },
  };

  static const _roleEditFeatures = <String, Set<String>>{
    'admin': {
      'branches',
      'staff',
      'medications',
      'inventory',
      'sales',
      'prescriptions',
      'customer_orders',
      'suppliers',
      'purchase_orders',
      'shifts',
      'reports',
    },
    'manager': {
      'branches',
      'medications',
      'inventory',
      'sales',
      'prescriptions',
      'customer_orders',
      'suppliers',
      'purchase_orders',
      'shifts',
      'reports',
    },
    'pharmacist': {
      'medications',
      'inventory',
      'sales',
      'prescriptions',
      'customer_orders',
    },
    'technician': {
      'medications',
      'inventory',
    },
    'cashier': {
      'sales',
      'customer_orders',
    },
  };

  static const _roleDeleteFeatures = <String, Set<String>>{
    'admin': {
      'branches',
      'staff',
      'medications',
      'inventory',
      'sales',
      'prescriptions',
      'customer_orders',
      'suppliers',
      'purchase_orders',
      'shifts',
    },
    'manager': {
      'medications',
      'inventory',
      'sales',
      'prescriptions',
      'customer_orders',
      'suppliers',
      'purchase_orders',
      'shifts',
    },
  };

  static bool canAccessRoute(String role, String route) {
    final routes = _roleRoutes[role];

    if (routes == null) return false;

    return routes.contains(route);
  }

  static bool canEdit(String role, String feature) {
    final features = _roleEditFeatures[role];

    if (features == null) return false;

    return features.contains(feature);
  }

  static bool canDelete(String role, String feature) {
    final features = _roleDeleteFeatures[role];

    if (features == null) return false;

    return features.contains(feature);
  }

  static Set<String> accessibleRoutes(String role) {
    return _roleRoutes[role] ?? {};
  }

  static String defaultRouteForRole(String role) {
    return AppRoutes.dashboard;
  }
}
