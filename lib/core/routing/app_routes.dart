import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacypro/core/routing/app_names_rour=tes.dart';

import '../../features/branches/presentation/screens/branches_screen.dart';
import '../../features/customer_orders/presentation/screens/customer_orders_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/medications/presentation/screens/medications_screen.dart';
import '../../features/prescriptions/presentation/screens/prescriptions_screen.dart';
import '../../features/purchase_orders/presentation/screens/purchase_orders_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/sales/presentation/screens/sales_screen.dart';
import '../../features/shifts/presentation/screens/shifts_screen.dart';
import '../../features/staff/presentation/screens/staff_screen.dart';
import '../../features/suppliers/presentation/screens/suppliers_screen.dart';
import '../common/widgets/app_shell.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.dashboard,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DashboardScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.inventory,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: InventoryScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.medications,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: MedicationsScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.sales,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: SalesScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.prescriptions,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: PrescriptionsScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.orders,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: CustomerOrdersScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.suppliers,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: SuppliersScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.purchaseOrders,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: PurchaseOrdersScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.staff,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: StaffScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.shifts,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: ShiftsScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.branches,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: BranchesScreen());
          },
        ),
        GoRoute(
          path: AppRoutes.reports,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: ReportsScreen());
          },
        ),
      ],
    ),
  ],
);
