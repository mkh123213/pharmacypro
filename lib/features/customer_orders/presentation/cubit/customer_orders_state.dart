import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/customer_order_model.dart';

part 'customer_orders_state.freezed.dart';

@freezed
class CustomerOrdersState with _$CustomerOrdersState {
  const factory CustomerOrdersState.initial() = CustomerOrdersInitial;

  const factory CustomerOrdersState.loading() = CustomerOrdersLoading;

  const factory CustomerOrdersState.loaded({
    required List<CustomerOrderModel> orders,
    required List<MedicationModel> medications,
    required List<BranchModel> branches,
    @Default('') String searchQuery,
    @Default('all') String selectedStatus,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = CustomerOrdersLoaded;

  const factory CustomerOrdersState.failure({required String message}) =
      CustomerOrdersFailure;
}
