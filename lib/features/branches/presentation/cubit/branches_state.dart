import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/branch_model.dart';

part 'branches_state.freezed.dart';

@freezed
class BranchesState with _$BranchesState {
  const factory BranchesState.initial() = BranchesInitial;

  const factory BranchesState.loading() = BranchesLoading;

  const factory BranchesState.loaded({
    required List<BranchModel> branches,
    @Default('') String searchQuery,
    @Default('all') String selectedStatus,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = BranchesLoaded;

  const factory BranchesState.failure({required String message}) =
      BranchesFailure;
}
