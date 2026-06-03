import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import '../../permissions/permission_helper.dart';
import '../../routing/app_routes.dart';
import 'app_sidebar_controls.dart';
import 'app_sidebar_item.dart';
import 'app_sidebar_logo.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    final colors = context.color;
    final width = MediaQuery.sizeOf(context).width.clamp(240.0, 260.0).toDouble();
    final role = context.read<AuthCubit>().currentRole;

    final allItems = [
      _SidebarEntry(
        icon: Icons.dashboard_outlined,
        labelKey: LangKeys.dashboard,
        route: AppRoutes.dashboard,
      ),
      _SidebarEntry(
        icon: Icons.inventory_2_outlined,
        labelKey: LangKeys.inventory,
        route: AppRoutes.inventory,
      ),
      _SidebarEntry(
        icon: Icons.medication_outlined,
        labelKey: LangKeys.medications,
        route: AppRoutes.medications,
      ),
      _SidebarEntry(
        icon: Icons.point_of_sale_outlined,
        labelKey: LangKeys.salesAndPos,
        route: AppRoutes.sales,
      ),
      _SidebarEntry(
        icon: Icons.receipt_long_outlined,
        labelKey: LangKeys.prescriptions,
        route: AppRoutes.prescriptions,
      ),
      _SidebarEntry(
        icon: Icons.shopping_cart_outlined,
        labelKey: LangKeys.customerOrders,
        route: AppRoutes.orders,
      ),
      _SidebarEntry(
        icon: Icons.local_shipping_outlined,
        labelKey: LangKeys.suppliers,
        route: AppRoutes.suppliers,
      ),
      _SidebarEntry(
        icon: Icons.assignment_outlined,
        labelKey: LangKeys.purchaseOrders,
        route: AppRoutes.purchaseOrders,
      ),
      _SidebarEntry(
        icon: Icons.people_outlined,
        labelKey: LangKeys.staff,
        route: AppRoutes.staff,
      ),
      _SidebarEntry(
        icon: Icons.schedule_outlined,
        labelKey: LangKeys.shifts,
        route: AppRoutes.shifts,
      ),
      _SidebarEntry(
        icon: Icons.store_outlined,
        labelKey: LangKeys.branches,
        route: AppRoutes.branches,
      ),
      _SidebarEntry(
        icon: Icons.bar_chart_outlined,
        labelKey: LangKeys.reports,
        route: AppRoutes.reports,
      ),
    ];

    final visibleItems = allItems
        .where((item) => PermissionHelper.canAccessRoute(role, item.route))
        .toList();

    return Container(
      width: width,
      color: colors.sidebarBg,
      child: SafeArea(
        child: Column(
          children: [
            const AppSidebarLogo(),
            Divider(color: colors.sidebarActive, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: visibleItems
                    .map(
                      (item) => AppSidebarItem(
                        icon: item.icon,
                        label: context.translate(item.labelKey),
                        route: item.route,
                        isActive: currentRoute == item.route,
                        badgeCount: item.badgeCount,
                      ),
                    )
                    .toList(),
              ),
            ),
            const AppSidebarControls(),
          ],
        ),
      ),
    );
  }
}

class _SidebarEntry {
  const _SidebarEntry({
    required this.icon,
    required this.labelKey,
    required this.route,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String labelKey;
  final String route;
  final int badgeCount;
}
