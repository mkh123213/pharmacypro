import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../data/models/staff_model.dart';

part 'staff_state.freezed.dart';

@freezed
class StaffState with _$StaffState {
  const factory StaffState.initial() = StaffInitial;

  const factory StaffState.loading() = StaffLoading;

  const factory StaffState.loaded({
    required List<StaffModel> staff,
    required List<BranchModel> branches,
    @Default('') String searchQuery,
    @Default('all') String selectedRole,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = StaffLoaded;

  const factory StaffState.failure({required String message}) = StaffFailure;
}
