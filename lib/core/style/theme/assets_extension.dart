import 'package:flutter/material.dart';
import 'package:pharmacypro/constants/assets.dart';

/// Theme-aware asset paths. Read them via `context.assets.<name>` and the
/// correct light/dark image is returned automatically — no `isDark` checks at
/// call sites.
///
/// To add a new themed asset:
///   1. add `*Light` / `*Dark` paths in [AppImages],
///   2. add a `final String x;` field here (+ in the constructor, copyWith),
///   3. set it in [light] and [dark] below.
class MyAssets extends ThemeExtension<MyAssets> {
  const MyAssets({
    required this.navDashboard,
    required this.navSuppliers,
    required this.inventory,
    required this.medications,
    required this.salesAndPos,
    required this.customerOrders,
    required this.prescriptions,
    required this.suppliers,
    required this.purchaseOrders,
    required this.staff,
    required this.shifts,
    required this.branches,
    required this.reports,
    required this.themeMode,
    required this.logOut,
    required this.language,
    required this.lowStockInDashBoardScreen,
    required this.expiringSoonInDashBoardScreen,
    required this.expiredItemsInDashBoardScreen,
    required this.prescriptionsInDashBoardScreen,
    required this.staffInDashBoardScreen,
    required this.stockInInDashBoardScreen,
    required this.stockOutInDashBoardScreen,
    required this.manualAdjustmentInDashBoardScreen,
    required this.customerOrdersInDashBoardScreen,
    required this.totalRevenueInDashBoardScreen,
    required this.pendingPrescriptionsInDashBoardScreen,
    required this.noInventoryAlertsFound,
    required this.emptyInventory,
    required this.noBranchesYet,
    required this.noOrdersFound,
    required this.noStockMovementsFound,
    required this.noMedicationsFound,
    required this.noPrescriptionsFound,
    required this.noPurchaseOrdersFound,
    required this.noSalesFound,
    required this.noShiftsFound,
    required this.noStaffFound,
    required this.noSuppliersFound,
    required this.notifications,
    required this.appThemeButton,
    required this.appLanguageButton,
    required this.qrCodeScanner,
    required this.search,
    required this.draft,
    required this.sent,
    required this.confirmed,
    required this.received,
    required this.cancelled,
    required this.totalValue,
    required this.edit,
    required this.delete,
    required this.pharmacist,
    required this.technician,
    required this.cashier,
    required this.manager,
    required this.admin,
    required this.totalRevenue,
    required this.totalCost,
    required this.totalProfit,
    required this.totalMargin,
    required this.totalSales,
    required this.lowStockItems,
    required this.expiringSoon,
    required this.expiredItems,
    required this.healthyStock,
    required this.stockIn,
    required this.stockOut,
    required this.manualAdjustment,
    required this.appLogo,
  });
  // for nav bar in the dashboard screen

  final String navDashboard;
  final String navSuppliers;
  final String inventory;
  final String medications;
  final String salesAndPos;
  final String customerOrders;
  final String prescriptions;
  final String suppliers;
  final String purchaseOrders;
  final String staff;
  final String shifts;
  final String branches;
  final String reports;
  final String themeMode;
  final String logOut;
  final String language;
  final String pendingPrescriptionsInDashBoardScreen;

  // fot the dashboard screen
  final String lowStockInDashBoardScreen;
  final String expiringSoonInDashBoardScreen;
  final String expiredItemsInDashBoardScreen;
  final String prescriptionsInDashBoardScreen;
  final String staffInDashBoardScreen;
  final String stockInInDashBoardScreen;
  final String stockOutInDashBoardScreen;
  final String manualAdjustmentInDashBoardScreen;
  final String customerOrdersInDashBoardScreen;
  final String totalRevenueInDashBoardScreen;

  // for empty states
  final String noInventoryAlertsFound;
  final String emptyInventory;
  final String noBranchesYet;
  final String noOrdersFound;
  final String noStockMovementsFound;
  final String noMedicationsFound;
  final String noPrescriptionsFound;
  final String noPurchaseOrdersFound;
  final String noSalesFound;
  final String noShiftsFound;
  final String noStaffFound;
  final String noSuppliersFound;
  // for the app top bar
  final String notifications;
  final String appThemeButton;
  final String appLanguageButton;
  final String qrCodeScanner;
  //// for inventor screen
  final String search;
  // for purcashes orders screen
  final String draft;
  final String sent;
  final String confirmed;
  final String received;
  final String cancelled;
  final String totalValue;
  // for staff screen
  final String edit;
  final String delete;
  final String pharmacist;
  final String technician;
  final String cashier;
  final String manager;
  final String admin;

  // for the report screen
  final String totalRevenue;
  final String totalCost;
  final String totalProfit;
  final String totalMargin;
  final String totalSales;
  final String lowStockItems;
  final String expiringSoon;
  final String expiredItems;
  final String healthyStock;

  final String stockIn;
  final String stockOut;
  final String manualAdjustment;
  final String appLogo;

  @override
  ThemeExtension<MyAssets> copyWith({
    String? navDashboard,
    String? navSuppliers,
    String? customerOrders,
    String? inventory,
    String? medications,
    String? prescriptions,
    String? purchaseOrders,
    String? salesAndPos,
    String? staff,
    String? suppliers,
    String? shifts,
    String? reports,
    String? branches,
    String? themeMode,
    String? logOut,
    String? language,
    String? lowStockInDashBoardScreen,
    String? expiringSoonInDashBoardScreen,
    String? expiredItemsInDashBoardScreen,
    String? prescriptionsInDashBoardScreen,
    String? staffInDashBoardScreen,
    String? stockInInDashBoardScreen,
    String? stockOutInDashBoardScreen,
    String? manualAdjustmentInDashBoardScreen,
    String? customerOrdersInDashBoardScreen,
    String? totalRevenueInDashBoardScreen,
    String? pendingPrescriptionsInDashBoardScreen,

    String? noInventoryAlertsFound,
    String? emptyInventory,
    String? noBranchesYet,
    String? noOrdersFound,
    String? noStockMovementsFound,
    String? noMedicationsFound,
    String? noPrescriptionsFound,
    String? noPurchaseOrdersFound,
    String? noSalesFound,
    String? noShiftsFound,
    String? noStaffFound,
    String? noSuppliersFound,
    // for the app top bar
    String? notifications,
    String? appThemeButton,
    String? appLanguageButton,
    String? qrCodeScanner,
    String? search,
    String? draft,
    String? sent,
    String? confirmed,
    String? received,
    String? cancelled,
    String? totalValue,
    String? edit,
    String? delete,
    String? pharmacist,
    String? technician,
    String? cashier,
    String? manager,
    String? admin,

    // for reports screen
    String? totalRevenue,
    String? totalCost,
    String? totalProfit,
    String? totalMargin,
    String? totalSales,
    String? lowStockItems,
    String? expiringSoon,
    String? expiredItems,
    String? healthyStock,

    String? stockIn,
    String? stockOut,
    String? manualAdjustment,
    String? appLogo,
  }) {
    return MyAssets(
      navDashboard: navDashboard ?? this.navDashboard,
      navSuppliers: navSuppliers ?? this.navSuppliers,
      customerOrders: customerOrders ?? this.customerOrders,
      inventory: inventory ?? this.inventory,
      medications: medications ?? this.medications,
      prescriptions: prescriptions ?? this.prescriptions,
      purchaseOrders: customerOrders ?? this.purchaseOrders,
      salesAndPos: salesAndPos ?? this.salesAndPos,
      staff: staff ?? this.staff,
      suppliers: suppliers ?? this.suppliers,
      shifts: shifts ?? this.shifts,
      branches: branches ?? this.branches,
      reports: reports ?? this.reports,
      themeMode: themeMode ?? this.themeMode,
      logOut: logOut ?? this.logOut,
      language: language ?? this.language,
      lowStockInDashBoardScreen:
          lowStockInDashBoardScreen ?? this.lowStockInDashBoardScreen,
      expiringSoonInDashBoardScreen:
          expiringSoonInDashBoardScreen ?? this.expiringSoonInDashBoardScreen,
      expiredItemsInDashBoardScreen:
          expiredItemsInDashBoardScreen ?? this.expiredItemsInDashBoardScreen,
      prescriptionsInDashBoardScreen:
          prescriptionsInDashBoardScreen ?? this.prescriptionsInDashBoardScreen,
      staffInDashBoardScreen:
          staffInDashBoardScreen ?? this.staffInDashBoardScreen,
      stockInInDashBoardScreen:
          stockInInDashBoardScreen ?? this.stockInInDashBoardScreen,
      stockOutInDashBoardScreen:
          stockOutInDashBoardScreen ?? this.stockOutInDashBoardScreen,
      manualAdjustmentInDashBoardScreen:
          manualAdjustmentInDashBoardScreen ??
          this.manualAdjustmentInDashBoardScreen,
      customerOrdersInDashBoardScreen:
          customerOrdersInDashBoardScreen ??
          this.customerOrdersInDashBoardScreen,
      totalRevenueInDashBoardScreen:
          totalRevenueInDashBoardScreen ?? this.totalRevenueInDashBoardScreen,
      pendingPrescriptionsInDashBoardScreen:
          pendingPrescriptionsInDashBoardScreen ??
          this.pendingPrescriptionsInDashBoardScreen,
      emptyInventory: emptyInventory ?? this.emptyInventory,
      noInventoryAlertsFound:
          noInventoryAlertsFound ?? this.noInventoryAlertsFound,
      // for empty states
      noBranchesYet: noBranchesYet ?? this.noBranchesYet,
      noOrdersFound: noOrdersFound ?? this.noOrdersFound,
      noStockMovementsFound:
          noStockMovementsFound ?? this.noStockMovementsFound,
      noMedicationsFound: noMedicationsFound ?? this.noMedicationsFound,
      noPrescriptionsFound: noPrescriptionsFound ?? this.noPrescriptionsFound,
      noPurchaseOrdersFound:
          noPurchaseOrdersFound ?? this.noPurchaseOrdersFound,
      noSalesFound: noSalesFound ?? this.noSalesFound,
      noShiftsFound: noShiftsFound ?? this.noShiftsFound,
      noStaffFound: noStaffFound ?? this.noStaffFound,
      noSuppliersFound: noSuppliersFound ?? this.noSuppliersFound,
      notifications: notifications ?? this.notifications,
      appThemeButton: appThemeButton ?? this.appThemeButton,
      appLanguageButton: appLanguageButton ?? this.appLanguageButton,
      qrCodeScanner: qrCodeScanner ?? this.qrCodeScanner,
      search: search ?? this.search,
      draft: draft ?? this.draft,
      sent: sent ?? this.sent,
      confirmed: confirmed ?? this.confirmed,
      received: received ?? this.received,
      cancelled: cancelled ?? this.cancelled,
      totalValue: totalValue ?? this.totalValue,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
      pharmacist: pharmacist ?? this.pharmacist,
      technician: technician ?? this.technician,
      cashier: cashier ?? this.cashier,
      manager: manager ?? this.manager,
      admin: admin ?? this.admin,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalCost: totalCost ?? this.totalCost,
      totalProfit: totalProfit ?? this.totalProfit,
      totalMargin: totalMargin ?? this.totalMargin,
      totalSales: totalSales ?? this.totalSales,
      lowStockItems: lowStockItems ?? this.lowStockItems,
      expiringSoon: expiringSoon ?? this.expiringSoon,
      expiredItems: expiredItems ?? this.expiredItems,
      healthyStock: healthyStock ?? this.healthyStock,
      stockIn: stockIn ?? this.stockIn,
      stockOut: stockOut ?? this.stockOut,
      manualAdjustment: manualAdjustment ?? this.manualAdjustment,
      appLogo: appLogo ?? this.appLogo,
    );
  }

  @override
  ThemeExtension<MyAssets> lerp(
    covariant ThemeExtension<MyAssets>? other,
    double t,
  ) {
    if (other is! MyAssets) {
      return this;
    }
    // Asset paths can't be interpolated, so snap to the target past the midpoint.
    return t < 0.5 ? this : other;
  }

  static const MyAssets light = MyAssets(
    navDashboard: Assets.assetsImages2ActionDeleteDark,
    navSuppliers: Assets.assetsImages2NavSuppliersLight,
    inventory: Assets.assetsImages2NavInventoryLight,
    customerOrders: Assets.assetsImages2NavCustomerOrdersLight,
    medications: Assets.assetsImages2NavMedicationsLight,
    prescriptions: Assets.assetsImages2NavPrescriptionsLight,
    purchaseOrders: Assets.assetsImages2NavPurchaseOrdersLight,
    salesAndPos: Assets.assetsImages2NavSalesPosLight,
    staff: Assets.assetsImages2NavStaffLight,
    suppliers: Assets.assetsImages2NavSuppliersLight,
    shifts: Assets.assetsImages2NavShiftsLight,
    branches: Assets.assetsImages2NavBranchesLight,
    reports: Assets.assetsImages2NavReportsLight,
    themeMode: Assets.assetsImages2ActionThemeLight,
    logOut: Assets.assetsImages2ActionLogoutLight,
    language: Assets.assetsImages2ActionLanguageLight,
    // for the dashboard screen
    lowStockInDashBoardScreen: Assets.assetsImages2StatLowStockLight,
    expiringSoonInDashBoardScreen: Assets.assetsImages2StatExpiringSoonLight,
    expiredItemsInDashBoardScreen: Assets.assetsImages2StatExpiredItemsLight,
    prescriptionsInDashBoardScreen: Assets.assetsImages2StatPrescriptionsLight,
    staffInDashBoardScreen: Assets.assetsImages2NavStaffLight,
    stockInInDashBoardScreen: Assets.assetsImages2StatStockInLight,
    stockOutInDashBoardScreen: Assets.assetsImages2StatStockOutLight,
    manualAdjustmentInDashBoardScreen:
        Assets.assetsImages2StatManualAdjustmentLight,
    customerOrdersInDashBoardScreen: Assets.assetsImages2NavCustomerOrdersLight,
    totalRevenueInDashBoardScreen: Assets.assetsImages2StatTotalRevenueLight,
    pendingPrescriptionsInDashBoardScreen:
        Assets.assetsImages2StatusPendingLight,

    // for empty states
    noInventoryAlertsFound: Assets.assetsImages2EmptyInventoryLight,
    emptyInventory: Assets.assetsImages2EmptyInventoryLight,
    noBranchesYet: Assets.assetsImages2EmptyBranchesLight,
    noOrdersFound: Assets.assetsImages2EmptyCustomerOrdersLight,
    noStockMovementsFound: Assets.assetsImages2StatStockInLight,
    noMedicationsFound: Assets.assetsImages2NavMedicationsLight,
    noPrescriptionsFound: Assets.assetsImages2EmptyPrescriptionsLight,
    noPurchaseOrdersFound: Assets.assetsImages2EmptyPurchaseOrdersLight,
    noSalesFound: Assets.assetsImages2EmptySalesLight,
    noShiftsFound: Assets.assetsImages2EmptyShiftsLight,
    noStaffFound: Assets.assetsImages2EmptyStaffLight,
    noSuppliersFound: Assets.assetsImages2EmptySuppliersLight,
    notifications: Assets.assetsImages2NotificationLight,
    appThemeButton: Assets.assetsImages2ActionThemeLight,
    appLanguageButton: Assets.assetsImages2ActionLanguageLight,
    qrCodeScanner: Assets.assetsImages2ActionQrLight,
    search: Assets.assetsImages2ActionSearchLight,
    draft: Assets.assetsImages2StatusPendingLight,
    sent: Assets.assetsImages2StatusSentLight,
    confirmed: Assets.assetsImages2StatusConfirmedLight,
    received: Assets.assetsImages2StatusReceivedLight,
    cancelled: Assets.assetsImages2StatusCancelledLight,
    totalValue: Assets.assetsImages2StatTotalCostLight,
    edit: Assets.assetsImages2ActionEditLight,
    delete: Assets.assetsImages2ActionDeleteLight,
    pharmacist: Assets.assetsImages2RolePharmacistLight,
    technician: Assets.assetsImages2RoleTechnicianLight,
    cashier: Assets.assetsImages2RoleCashierLight,
    manager: Assets.assetsImages2RoleManagerLight,
    admin: Assets.assetsImages2RoleAdminLight,
    totalRevenue: Assets.assetsImages2StatTotalRevenueLight,
    totalCost: Assets.assetsImages2StatTotalCostLight,
    totalProfit: Assets.assetsImages2StatTotalProfitLight,
    totalMargin: Assets.assetsImages2ActionSearchDark,
    totalSales: Assets.assetsImages2StatTotalSalesLight,
    lowStockItems: Assets.assetsImages2StatLowStockLight,
    expiringSoon: Assets.assetsImages2StatExpiringSoonLight,
    expiredItems: Assets.assetsImages2StatExpiredItemsLight,
    healthyStock: Assets.assetsImages2StatHealthyStockLight,
    stockIn: Assets.assetsImages2StatStockInLight,
    stockOut: Assets.assetsImages2StatStockOutDark,
    manualAdjustment: Assets.assetsImages2StatManualAdjustmentLight,
    appLogo: Assets.assetsImages2BrandLogoLight,
  );

  static const MyAssets dark = MyAssets(
    navDashboard: Assets.assetsImages2NavDashboard,

    navSuppliers: Assets.assetsImages2NavSuppliersDark,
    inventory: Assets.assetsImages2NavInventoryDark,
    customerOrders: Assets.assetsImages2NavCustomerOrdersDark,
    medications: Assets.assetsImages2NavMedicationsDark,
    prescriptions: Assets.assetsImages2NavPrescriptionsDark,
    purchaseOrders: Assets.assetsImages2NavPurchaseOrdersDark,
    salesAndPos: Assets.assetsImages2NavSalesPosDark,
    staff: Assets.assetsImages2NavStaffDark,
    suppliers: Assets.assetsImages2NavSuppliersDark,
    shifts: Assets.assetsImages2NavShiftsDark,
    branches: Assets.assetsImages2NavBranchesDark,
    reports: Assets.assetsImages2NavReportsDark,
    themeMode: Assets.assetsImages2NavReportsDark,
    logOut: Assets.assetsImages2ActionLogoutDark,
    language: Assets.assetsImages2ActionLanguageDark,
    // for the dashboard screen
    lowStockInDashBoardScreen: Assets.assetsImages2StatLowStockDark,
    expiringSoonInDashBoardScreen: Assets.assetsImages2StatExpiringSoonDark,
    expiredItemsInDashBoardScreen: Assets.assetsImages2StatExpiredItemsDark,
    prescriptionsInDashBoardScreen: Assets.assetsImages2StatPrescriptionsDark,
    staffInDashBoardScreen: Assets.assetsImages2NavStaffDark,
    stockInInDashBoardScreen: Assets.assetsImages2StatStockInDark,
    stockOutInDashBoardScreen: Assets.assetsImages2StatStockOutDark,
    manualAdjustmentInDashBoardScreen:
        Assets.assetsImages2StatManualAdjustmentDark,
    customerOrdersInDashBoardScreen: Assets.assetsImages2NavCustomerOrdersDark,
    totalRevenueInDashBoardScreen: Assets.assetsImages2StatTotalRevenueDark,
    pendingPrescriptionsInDashBoardScreen:
        Assets.assetsImages2StatusPendingDark,

    // for empty states
    noInventoryAlertsFound: Assets.assetsImages2EmptyInventoryDark,
    emptyInventory: Assets.assetsImages2EmptyInventoryDark,
    noBranchesYet: Assets.assetsImages2EmptyBranchesDark,
    noOrdersFound: Assets.assetsImages2EmptyCustomerOrdersDark,
    noStockMovementsFound: Assets.assetsImages2StatStockInDark,
    noMedicationsFound: Assets.assetsImages2NavMedicationsDark,
    noPrescriptionsFound: Assets.assetsImages2EmptyPrescriptionsDark,
    noPurchaseOrdersFound: Assets.assetsImages2EmptyPurchaseOrdersDark,
    noSalesFound: Assets.assetsImages2EmptySalesDark,
    noShiftsFound: Assets.assetsImages2EmptyShiftsDark,
    noStaffFound: Assets.assetsImages2EmptyStaffDark,
    noSuppliersFound: Assets.assetsImages2EmptySuppliersDark,
    notifications: Assets.assetsImages2NotificationsDark,
    appThemeButton: Assets.assetsImages2ActionThemeDark,
    appLanguageButton: Assets.assetsImages2ActionLanguageDark,
    qrCodeScanner: Assets.assetsImages2ActionQrDark,
    search: Assets.assetsImages2ActionSearchDark,

    draft: Assets.assetsImages2StatusPendingLight,
    sent: Assets.assetsImages2StatusSentLight,
    confirmed: Assets.assetsImages2StatusConfirmedLight,
    received: Assets.assetsImages2StatusReceivedDark,
    cancelled: Assets.assetsImages2StatusCancelledDark,
    totalValue: Assets.assetsImages2StatTotalCostDark,
    edit: Assets.assetsImages2ActionEditLight,
    delete: Assets.assetsImages2ActionDeleteDark,
    pharmacist: Assets.assetsImages2RolePharmacistDark,
    technician: Assets.assetsImages2RoleTechnicianDark,
    cashier: Assets.assetsImages2RoleCashierDark,
    manager: Assets.assetsImages2RoleManagerDark,
    admin: Assets.assetsImages2RoleAdminDark,

    totalRevenue: Assets.assetsImages2StatTotalRevenueDark,
    totalCost: Assets.assetsImages2StatTotalCostDark,
    totalProfit: Assets.assetsImages2StatTotalProfitDark,
    totalMargin: Assets.assetsImages2ActionSearchDark,
    totalSales: Assets.assetsImages2StatTotalSalesDark,
    lowStockItems: Assets.assetsImages2StatLowStockDark,
    expiringSoon: Assets.assetsImages2StatExpiringSoonDark,
    expiredItems: Assets.assetsImages2StatExpiredItemsDark,
    healthyStock: Assets.assetsImages2StatHealthyStockDark,
    stockIn: Assets.assetsImages2StatStockInDark,
    stockOut: Assets.assetsImages2StatStockOutLight,
    manualAdjustment: Assets.assetsImages2StatManualAdjustmentDark,
    appLogo: Assets.assetsImages2BrandLogoDark,
  );
}
