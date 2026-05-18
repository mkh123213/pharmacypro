import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/prescription_model.dart';
import '../../../branches/data/models/branch_model.dart';

part 'prescriptions_state.freezed.dart';

@freezed
class PrescriptionsState with _$PrescriptionsState {
  const factory PrescriptionsState.initial() = PrescriptionsInitial;
  const factory PrescriptionsState.loading() = PrescriptionsLoading;
  const factory PrescriptionsState.loaded({
    required List<PrescriptionModel> prescriptions, required List<BranchModel> branches, @Default('') String searchQuery, @Default('all') String selectedStatus, @Default(false) bool isSubmitting,
  }) = PrescriptionsLoaded;
  const factory PrescriptionsState.failure({required String message}) = PrescriptionsFailure;
}
