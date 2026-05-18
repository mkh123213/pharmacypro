import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacypro/core/app/app_cubit/app_cubit.dart';

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
import '../../features/inventory/presentation/cubit/inventory_cubit.dart';
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

final getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

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

void _registerCore() {
  final navigatorKey = GlobalKey<NavigatorState>();

  getIt
    ..registerFactory(AppCubit.new)
    ..registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);
}

void _registerBranches() {
  getIt.registerLazySingleton<BranchesRemoteDataSource>(
    () => BranchesRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<BranchesRepo>(
    () => BranchesRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<BranchesCubit>(
    () => BranchesCubit(branchesRepo: getIt()),
  );
}

void _registerSuppliers() {
  getIt.registerLazySingleton<SuppliersRemoteDataSource>(
    () => SuppliersRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<SuppliersRepo>(
    () => SuppliersRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<SuppliersCubit>(
    () => SuppliersCubit(suppliersRepo: getIt()),
  );
}

void _registerStaff() {
  getIt.registerLazySingleton<StaffRemoteDataSource>(
    () => StaffRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<StaffRepo>(
    () => StaffRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<StaffCubit>(() => StaffCubit(staffRepo: getIt()));
}

void _registerMedications() {
  getIt.registerLazySingleton<MedicationsRemoteDataSource>(
    () => MedicationsRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<MedicationsRepo>(
    () => MedicationsRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<MedicationsCubit>(
    () => MedicationsCubit(medicationsRepo: getIt()),
  );
}

void _registerInventory() {
  getIt.registerLazySingleton<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<InventoryRepo>(
    () => InventoryRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<InventoryCubit>(
    () => InventoryCubit(inventoryRepo: getIt()),
  );
}

void _registerSales() {
  getIt.registerLazySingleton<SalesRemoteDataSource>(
    () => SalesRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<SalesRepo>(
    () => SalesRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<SalesCubit>(() => SalesCubit(salesRepo: getIt()));
}

void _registerCustomerOrders() {
  getIt.registerLazySingleton<CustomerOrdersRemoteDataSource>(
    () => CustomerOrdersRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<CustomerOrdersRepo>(
    () => CustomerOrdersRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<CustomerOrdersCubit>(
    () => CustomerOrdersCubit(customerOrdersRepo: getIt()),
  );
}

void _registerPrescriptions() {
  getIt.registerLazySingleton<PrescriptionsRemoteDataSource>(
    () => PrescriptionsRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<PrescriptionsRepo>(
    () => PrescriptionsRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<PrescriptionsCubit>(
    () => PrescriptionsCubit(prescriptionsRepo: getIt()),
  );
}

void _registerPurchaseOrders() {
  getIt.registerLazySingleton<PurchaseOrdersRemoteDataSource>(
    () => PurchaseOrdersRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<PurchaseOrdersRepo>(
    () => PurchaseOrdersRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<PurchaseOrdersCubit>(
    () => PurchaseOrdersCubit(purchaseOrdersRepo: getIt()),
  );
}

void _registerShifts() {
  getIt.registerLazySingleton<ShiftsRemoteDataSource>(
    () => ShiftsRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<ShiftsRepo>(
    () => ShiftsRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<ShiftsCubit>(() => ShiftsCubit(shiftsRepo: getIt()));
}

void _registerDashboard() {
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(dashboardRepo: getIt()),
  );
}

void _registerReports() {
  getIt.registerLazySingleton<ReportsRemoteDataSource>(
    () => ReportsRemoteDataSource(firestore: getIt()),
  );

  getIt.registerLazySingleton<ReportsRepo>(
    () => ReportsRepo(remoteDataSource: getIt()),
  );

  getIt.registerFactory<ReportsCubit>(() => ReportsCubit(reportsRepo: getIt()));
}
