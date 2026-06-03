import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../../data/models/purchase_order_model.dart';

part 'purchase_orders_state.freezed.dart';

@freezed
class PurchaseOrdersState with _$PurchaseOrdersState {
  const factory PurchaseOrdersState.initial() = PurchaseOrdersInitial;

  const factory PurchaseOrdersState.loading() = PurchaseOrdersLoading;

  const factory PurchaseOrdersState.loaded({
    required List<PurchaseOrderModel> purchaseOrders,
    required List<SupplierModel> suppliers,
    required List<BranchModel> branches,
    required List<MedicationModel> medications,
    @Default('') String searchQuery,
    @Default('all') String selectedStatus,
    @Default('all') String selectedBranchId,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = PurchaseOrdersLoaded;

  const factory PurchaseOrdersState.failure({required String message}) =
      PurchaseOrdersFailure;
}
