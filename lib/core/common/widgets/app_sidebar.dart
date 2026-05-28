import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
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
                children: [
                  AppSidebarItem(
                    icon: Icons.dashboard_outlined,
                    label: context.translate(LangKeys.dashboard),
                    route: AppRoutes.dashboard,
                    isActive: currentRoute == AppRoutes.dashboard,
                  ),
                  AppSidebarItem(
                    icon: Icons.inventory_2_outlined,
                    label: context.translate(LangKeys.inventory),
                    route: AppRoutes.inventory,
                    isActive: currentRoute == AppRoutes.inventory,
                  ),
                  AppSidebarItem(
                    icon: Icons.medication_outlined,
                    label: context.translate(LangKeys.medications),
                    route: AppRoutes.medications,
                    isActive: currentRoute == AppRoutes.medications,
                  ),
                  AppSidebarItem(
                    icon: Icons.point_of_sale_outlined,
                    label: context.translate(LangKeys.salesAndPos),
                    route: AppRoutes.sales,
                    isActive: currentRoute == AppRoutes.sales,
                  ),
                  AppSidebarItem(
                    icon: Icons.receipt_long_outlined,
                    label: context.translate(LangKeys.prescriptions),
                    route: AppRoutes.prescriptions,
                    isActive: currentRoute == AppRoutes.prescriptions,
                  ),
                  AppSidebarItem(
                    icon: Icons.shopping_cart_outlined,
                    label: context.translate(LangKeys.customerOrders),
                    route: AppRoutes.orders,
                    isActive: currentRoute == AppRoutes.orders,
                  ),
                  AppSidebarItem(
                    icon: Icons.local_shipping_outlined,
                    label: context.translate(LangKeys.suppliers),
                    route: AppRoutes.suppliers,
                    isActive: currentRoute == AppRoutes.suppliers,
                  ),
                  AppSidebarItem(
                    icon: Icons.assignment_outlined,
                    label: context.translate(LangKeys.purchaseOrders),
                    route: AppRoutes.purchaseOrders,
                    isActive: currentRoute == AppRoutes.purchaseOrders,
                  ),
                  AppSidebarItem(
                    icon: Icons.people_outlined,
                    label: context.translate(LangKeys.staff),
                    route: AppRoutes.staff,
                    isActive: currentRoute == AppRoutes.staff,
                  ),
                  AppSidebarItem(
                    icon: Icons.schedule_outlined,
                    label: context.translate(LangKeys.shifts),
                    route: AppRoutes.shifts,
                    isActive: currentRoute == AppRoutes.shifts,
                  ),
                  AppSidebarItem(
                    icon: Icons.store_outlined,
                    label: context.translate(LangKeys.branches),
                    route: AppRoutes.branches,
                    isActive: currentRoute == AppRoutes.branches,
                  ),
                  AppSidebarItem(
                    icon: Icons.bar_chart_outlined,
                    label: context.translate(LangKeys.reports),
                    route: AppRoutes.reports,
                    isActive: currentRoute == AppRoutes.reports,
                  ),
                ],
              ),
            ),
            const AppSidebarControls(),
          ],
        ),
      ),
    );
  }
}
