import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/prescription_model.dart';

part 'prescriptions_state.freezed.dart';

@freezed
class PrescriptionsState with _$PrescriptionsState {
  const factory PrescriptionsState.initial() = PrescriptionsInitial;

  const factory PrescriptionsState.loading() = PrescriptionsLoading;

  const factory PrescriptionsState.loaded({
    required List<PrescriptionModel> prescriptions,
    required List<BranchModel> branches,
    required List<MedicationModel> medications,
    @Default('') String searchQuery,
    @Default('all') String selectedStatus,
    @Default('all') String selectedBranchId,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
  }) = PrescriptionsLoaded;

  const factory PrescriptionsState.failure({required String message}) =
      PrescriptionsFailure;
}
