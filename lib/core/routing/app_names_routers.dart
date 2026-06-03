import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/branches/presentation/screens/branches_screen.dart';
import '../../features/customer_orders/presentation/screens/customer_orders_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/inventory/presentation/screens/inventory_alerts_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/inventory/presentation/screens/stock_movements_screen.dart';
import '../../features/medications/presentation/screens/medications_screen.dart';
import '../../features/prescriptions/presentation/screens/prescriptions_screen.dart';
import '../../features/purchase_orders/presentation/screens/purchase_orders_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/sales/presentation/screens/sales_screen.dart';
import '../../features/shifts/presentation/screens/shifts_screen.dart';
import '../../features/staff/presentation/screens/staff_screen.dart';
import '../../features/suppliers/presentation/screens/suppliers_screen.dart';
import '../common/widgets/app_shell.dart';
import '../permissions/permission_helper.dart';
import 'app_routes.dart';

GoRouter createAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    refreshListenable: _AuthRefreshListenable(authCubit),
    redirect: (context, state) {
      final authState = authCubit.state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isLoginRoute) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isLoginRoute) {
        return AppRoutes.dashboard;
      }

      if (isAuthenticated) {
        final role = authCubit.currentRole;
        final route = state.matchedLocation;

        if (!PermissionHelper.canAccessRoute(role, route)) {
          return AppRoutes.dashboard;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.inventory,
            builder: (context, state) => const InventoryScreen(),
          ),
          GoRoute(
            path: AppRoutes.medications,
            builder: (context, state) => const MedicationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.sales,
            builder: (context, state) => const SalesScreen(),
          ),
          GoRoute(
            path: AppRoutes.prescriptions,
            builder: (context, state) => const PrescriptionsScreen(),
          ),
          GoRoute(
            path: AppRoutes.orders,
            builder: (context, state) => const CustomerOrdersScreen(),
          ),
          GoRoute(
            path: AppRoutes.suppliers,
            builder: (context, state) => const SuppliersScreen(),
          ),
          GoRoute(
            path: AppRoutes.purchaseOrders,
            builder: (context, state) => const PurchaseOrdersScreen(),
          ),
          GoRoute(
            path: AppRoutes.staff,
            builder: (context, state) => const StaffScreen(),
          ),
          GoRoute(
            path: AppRoutes.shifts,
            builder: (context, state) => const ShiftsScreen(),
          ),
          GoRoute(
            path: AppRoutes.branches,
            builder: (context, state) => const BranchesScreen(),
          ),
          GoRoute(
            path: AppRoutes.reports,
            builder: (context, state) => const ReportsScreen(),
          ),
          GoRoute(
            path: AppRoutes.stockHistory,
            builder: (context, state) => const StockMovementsScreen(),
          ),
          GoRoute(
            path: AppRoutes.inventoryAlerts,
            builder: (context, state) {
              return InventoryAlertsScreen(
                initialType: state.uri.queryParameters['type'],
              );
            },
          ),
        ],
      ),
    ],
  );
}

class _AuthRefreshListenable with ChangeNotifier {
  _AuthRefreshListenable(AuthCubit authCubit) {
    authCubit.stream.listen((_) => notifyListeners());
  }
}
