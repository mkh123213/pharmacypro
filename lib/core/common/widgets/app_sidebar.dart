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
    final width = MediaQuery.sizeOf(
      context,
    ).width.clamp(240.0, 260.0).toDouble();
    final role = context.read<AuthCubit>().currentRole;

    final allItems = [
      _SidebarEntry(
        icon: Icons.dashboard_outlined,
        labelKey: LangKeys.dashboard,
        route: AppRoutes.dashboard,
        imagePath: context.assets.navDashboard,
      ),
      _SidebarEntry(
        icon: Icons.inventory_2_outlined,
        labelKey: LangKeys.inventory,
        route: AppRoutes.inventory,
        imagePath: context.assets.inventory,
      ),
      _SidebarEntry(
        icon: Icons.medication_outlined,
        labelKey: LangKeys.medications,
        route: AppRoutes.medications,
        imagePath: context.assets.medications,
      ),
      _SidebarEntry(
        icon: Icons.point_of_sale_outlined,
        labelKey: LangKeys.salesAndPos,
        route: AppRoutes.sales,
        imagePath: context.assets.salesAndPos,
      ),
      _SidebarEntry(
        icon: Icons.receipt_long_outlined,
        labelKey: LangKeys.prescriptions,
        route: AppRoutes.prescriptions,
        imagePath: context.assets.prescriptions,
      ),
      _SidebarEntry(
        icon: Icons.shopping_cart_outlined,
        labelKey: LangKeys.customerOrders,
        route: AppRoutes.orders,
        imagePath: context.assets.customerOrders,
      ),
      _SidebarEntry(
        icon: Icons.local_shipping_outlined,
        labelKey: LangKeys.suppliers,
        route: AppRoutes.suppliers,
        imagePath: context.assets.suppliers,
      ),
      _SidebarEntry(
        icon: Icons.assignment_outlined,
        labelKey: LangKeys.purchaseOrders,
        route: AppRoutes.purchaseOrders,
        imagePath: context.assets.purchaseOrders,
      ),
      _SidebarEntry(
        icon: Icons.people_outlined,
        labelKey: LangKeys.staff,
        route: AppRoutes.staff,
        imagePath: context.assets.staff,
      ),
      _SidebarEntry(
        icon: Icons.schedule_outlined,
        labelKey: LangKeys.shifts,
        route: AppRoutes.shifts,
        imagePath: context.assets.shifts,
      ),
      _SidebarEntry(
        icon: Icons.store_outlined,
        labelKey: LangKeys.branches,
        route: AppRoutes.branches,
        imagePath: context.assets.branches,
      ),
      _SidebarEntry(
        icon: Icons.bar_chart_outlined,
        labelKey: LangKeys.reports,
        route: AppRoutes.reports,
        imagePath: context.assets.reports,
      ),
    ];

    final visibleItems = allItems
        .where((item) => PermissionHelper.canAccessRoute(role, item.route))
        .toList();

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colors.sidebarBg,
        border: BorderDirectional(end: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const AppSidebarLogo(),
            Divider(color: colors.border, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: visibleItems
                    .map(
                      (item) => AppSidebarItem(
                        icon: item.icon,
                        imagePath: item.imagePath,
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
    required this.imagePath,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String labelKey;
  final String route;
  final String imagePath;
  final int badgeCount;
}
