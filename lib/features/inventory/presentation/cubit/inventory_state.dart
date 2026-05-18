import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/inventory_model.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';

part 'inventory_state.freezed.dart';

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState.initial() = InventoryInitial;
  const factory InventoryState.loading() = InventoryLoading;
  const factory InventoryState.loaded({
    required List<InventoryModel> inventory, required List<MedicationModel> medications, required List<BranchModel> branches, @Default('') String searchQuery, @Default('all') String selectedBranchId, @Default(false) bool isSubmitting,
  }) = InventoryLoaded;
  const factory InventoryState.failure({required String message}) = InventoryFailure;
}
