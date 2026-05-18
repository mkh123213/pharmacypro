import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacypro/core/routing/app_names_rour=tes.dart';

import '../../routing/app_routes.dart';
import '../../theme/app_colors.dart';
import 'app_sidebar_item.dart';
import 'app_sidebar_logo.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Container(
      width: 260,
      color: AppColors.sidebarBg,
      child: Column(
        children: [
          const AppSidebarLogo(),
          const Divider(color: AppColors.sidebarActive, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                AppSidebarItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  route: AppRoutes.dashboard,
                  isActive: currentRoute == AppRoutes.dashboard,
                ),
                AppSidebarItem(
                  icon: Icons.inventory_2_outlined,
                  label: 'Inventory',
                  route: AppRoutes.inventory,
                  isActive: currentRoute == AppRoutes.inventory,
                ),
                AppSidebarItem(
                  icon: Icons.medication_outlined,
                  label: 'Medications',
                  route: AppRoutes.medications,
                  isActive: currentRoute == AppRoutes.medications,
                ),
                AppSidebarItem(
                  icon: Icons.point_of_sale_outlined,
                  label: 'Sales & POS',
                  route: AppRoutes.sales,
                  isActive: currentRoute == AppRoutes.sales,
                ),
                AppSidebarItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'Prescriptions',
                  route: AppRoutes.prescriptions,
                  isActive: currentRoute == AppRoutes.prescriptions,
                ),
                AppSidebarItem(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Customer Orders',
                  route: AppRoutes.orders,
                  isActive: currentRoute == AppRoutes.orders,
                ),
                AppSidebarItem(
                  icon: Icons.local_shipping_outlined,
                  label: 'Suppliers',
                  route: AppRoutes.suppliers,
                  isActive: currentRoute == AppRoutes.suppliers,
                ),
                AppSidebarItem(
                  icon: Icons.assignment_outlined,
                  label: 'Purchase Orders',
                  route: AppRoutes.purchaseOrders,
                  isActive: currentRoute == AppRoutes.purchaseOrders,
                ),
                AppSidebarItem(
                  icon: Icons.people_outlined,
                  label: 'Staff',
                  route: AppRoutes.staff,
                  isActive: currentRoute == AppRoutes.staff,
                ),
                AppSidebarItem(
                  icon: Icons.schedule_outlined,
                  label: 'Shifts',
                  route: AppRoutes.shifts,
                  isActive: currentRoute == AppRoutes.shifts,
                ),
                AppSidebarItem(
                  icon: Icons.store_outlined,
                  label: 'Branches',
                  route: AppRoutes.branches,
                  isActive: currentRoute == AppRoutes.branches,
                ),
                AppSidebarItem(
                  icon: Icons.bar_chart_outlined,
                  label: 'Reports',
                  route: AppRoutes.reports,
                  isActive: currentRoute == AppRoutes.reports,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
