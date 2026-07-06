import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/branches/data/data_source/branches_remote_data_source.dart';
import '../../features/branches/data/repos/branches_repo.dart';
import '../../features/branches/presentation/cubit/branches_cubit.dart';
import '../../features/customer_orders/data/data_source/customer_orders_remote_data_source.dart';
import '../../features/customer_orders/data/repos/customer_orders_repo.dart';
import '../../features/customer_orders/presentation/cubit/customer_orders_cubit.dart';
import '../../features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repos/dashboard_repo.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/inventory/data/data_source/inventory_remote_data_source.dart';
import '../../features/inventory/data/repos/inventory_repo.dart';
import '../../features/inventory/presentation/cubit/inventory_alerts_cubit.dart';
import '../../features/inventory/presentation/cubit/inventory_cubit.dart';
import '../../features/inventory/presentation/cubit/stock_movements_cubit.dart';
import '../../features/medications/data/data_source/medications_remote_data_source.dart';
import '../../features/medications/data/repos/medications_repo.dart';
import '../../features/medications/presentation/cubit/medications_cubit.dart';
import '../../features/prescriptions/data/data_source/prescriptions_remote_data_source.dart';
import '../../features/prescriptions/data/repos/prescriptions_repo.dart';
import '../../features/prescriptions/presentation/cubit/prescriptions_cubit.dart';
import '../../features/purchase_orders/data/data_source/purchase_orders_remote_data_source.dart';
import '../../features/purchase_orders/data/repos/purchase_orders_repo.dart';
import '../../features/purchase_orders/presentation/cubit/purchase_orders_cubit.dart';
import '../../features/reports/data/data_source/reports_remote_data_source.dart';
import '../../features/reports/data/repos/reports_repo.dart';
import '../../features/reports/presentation/cubit/reports_cubit.dart';
import '../../features/sales/data/data_source/sales_remote_data_source.dart';
import '../../features/sales/data/repos/sales_repo.dart';
import '../../features/sales/presentation/cubit/sales_cubit.dart';
import '../../features/shifts/data/data_source/shifts_remote_data_source.dart';
import '../../features/shifts/data/repos/shifts_repo.dart';
import '../../features/shifts/presentation/cubit/shifts_cubit.dart';
import '../../features/staff/data/data_source/staff_remote_data_source.dart';
import '../../features/staff/data/repos/staff_repo.dart';
import '../../features/staff/presentation/cubit/staff_cubit.dart';
import '../../features/suppliers/data/data_source/suppliers_remote_data_source.dart';
import '../../features/suppliers/data/repos/suppliers_repo.dart';
import '../../features/suppliers/presentation/cubit/suppliers_cubit.dart';
import '../app/app_cubit/app_cubit.dart';
import '../services/push_notification_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  _registerLazySingletonIfAbsent<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  _registerLazySingletonIfAbsent<FirebaseAuth>(() => FirebaseAuth.instance);

  _registerAuth();
  _registerCore();
  _registerBranches();
  _registerSuppliers();
  _registerStaff();
  _registerMedications();
  _registerInventory();
  _registerSales();
  _registerCustomerOrders();
  _registerPrescriptions();
  _registerPurchaseOrders();
  _registerShifts();
  _registerDashboard();
  _registerReports();
}

void _registerLazySingletonIfAbsent<T extends Object>(
  T Function() factoryFunc,
) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerLazySingleton<T>(factoryFunc);
  }
}

void _registerFactoryIfAbsent<T extends Object>(T Function() factoryFunc) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerFactory<T>(factoryFunc);
  }
}

void _registerSingletonIfAbsent<T extends Object>(T instance) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerSingleton<T>(instance);
  }
}

void _registerAuth() {
  _registerLazySingletonIfAbsent<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(firebaseAuth: getIt(), firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<AuthRepo>(
    () => AuthRepo(remoteDataSource: getIt()),
  );

  _registerLazySingletonIfAbsent<AuthCubit>(() => AuthCubit(authRepo: getIt()));
}

void _registerCore() {
  // final navigatorKey = GlobalKey<NavigatorState>();

  _registerSingletonIfAbsent<GlobalKey<NavigatorState>>(
    GlobalKey<NavigatorState>(),
  );

  _registerLazySingletonIfAbsent<PushNotificationService>(
    () => PushNotificationService(),
  );

  _registerFactoryIfAbsent<AppCubit>(AppCubit.new);
}

void _registerBranches() {
  _registerLazySingletonIfAbsent<BranchesRemoteDataSource>(
    () => BranchesRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<BranchesRepo>(
    () => BranchesRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<BranchesCubit>(
    () => BranchesCubit(branchesRepo: getIt()),
  );
}

void _registerSuppliers() {
  _registerLazySingletonIfAbsent<SuppliersRemoteDataSource>(
    () => SuppliersRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<SuppliersRepo>(
    () => SuppliersRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<SuppliersCubit>(
    () => SuppliersCubit(suppliersRepo: getIt()),
  );
}

void _registerStaff() {
  _registerLazySingletonIfAbsent<StaffRemoteDataSource>(
    () => StaffRemoteDataSource(firestore: getIt(), firebaseAuth: getIt()),
  );

  _registerLazySingletonIfAbsent<StaffRepo>(
    () => StaffRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<StaffCubit>(() => StaffCubit(staffRepo: getIt()));
}

void _registerMedications() {
  _registerLazySingletonIfAbsent<MedicationsRemoteDataSource>(
    () => MedicationsRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<MedicationsRepo>(
    () => MedicationsRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<MedicationsCubit>(
    () => MedicationsCubit(medicationsRepo: getIt()),
  );
}

void _registerInventory() {
  _registerLazySingletonIfAbsent<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<InventoryRepo>(
    () => InventoryRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<InventoryCubit>(
    () => InventoryCubit(inventoryRepo: getIt()),
  );

  _registerFactoryIfAbsent<StockMovementsCubit>(
    () => StockMovementsCubit(inventoryRepo: getIt<InventoryRepo>()),
  );

  _registerFactoryIfAbsent<InventoryAlertsCubit>(
    () => InventoryAlertsCubit(inventoryRepo: getIt<InventoryRepo>()),
  );
}

void _registerSales() {
  _registerLazySingletonIfAbsent<SalesRemoteDataSource>(
    () => SalesRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<SalesRepo>(
    () => SalesRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<SalesCubit>(() => SalesCubit(salesRepo: getIt()));
}

void _registerCustomerOrders() {
  _registerLazySingletonIfAbsent<CustomerOrdersRemoteDataSource>(
    () => CustomerOrdersRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<CustomerOrdersRepo>(
    () => CustomerOrdersRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<CustomerOrdersCubit>(
    () => CustomerOrdersCubit(customerOrdersRepo: getIt()),
  );
}

void _registerPrescriptions() {
  _registerLazySingletonIfAbsent<PrescriptionsRemoteDataSource>(
    () => PrescriptionsRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<PrescriptionsRepo>(
    () => PrescriptionsRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<PrescriptionsCubit>(
    () => PrescriptionsCubit(prescriptionsRepo: getIt()),
  );
}

void _registerPurchaseOrders() {
  _registerLazySingletonIfAbsent<PurchaseOrdersRemoteDataSource>(
    () => PurchaseOrdersRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<PurchaseOrdersRepo>(
    () => PurchaseOrdersRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<PurchaseOrdersCubit>(
    () => PurchaseOrdersCubit(purchaseOrdersRepo: getIt()),
  );
}

void _registerShifts() {
  _registerLazySingletonIfAbsent<ShiftsRemoteDataSource>(
    () => ShiftsRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<ShiftsRepo>(
    () => ShiftsRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<ShiftsCubit>(() => ShiftsCubit(shiftsRepo: getIt()));
}

void _registerDashboard() {
  _registerLazySingletonIfAbsent<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<DashboardRepo>(
    () => DashboardRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<DashboardCubit>(
    () => DashboardCubit(dashboardRepo: getIt()),
  );
}

void _registerReports() {
  _registerLazySingletonIfAbsent<ReportsRemoteDataSource>(
    () => ReportsRemoteDataSource(firestore: getIt()),
  );

  _registerLazySingletonIfAbsent<ReportsRepo>(
    () => ReportsRepo(remoteDataSource: getIt()),
  );

  _registerFactoryIfAbsent<ReportsCubit>(
    () => ReportsCubit(reportsRepo: getIt()),
  );
}
