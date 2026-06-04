import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/supplier_model.dart';

part 'suppliers_state.freezed.dart';

@freezed
class SuppliersState with _$SuppliersState {
  const factory SuppliersState.initial() = SuppliersInitial;

  const factory SuppliersState.loading() = SuppliersLoading;

  const factory SuppliersState.loaded({
    required List<SupplierModel> suppliers,
    @Default('') String searchQuery,
    @Default('all') String selectedStatus,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = SuppliersLoaded;

  const factory SuppliersState.failure({required String message}) =
      SuppliersFailure;
}
