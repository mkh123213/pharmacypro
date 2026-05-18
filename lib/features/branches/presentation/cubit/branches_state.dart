import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/branch_model.dart';


part 'branches_state.freezed.dart';

@freezed
class BranchesState with _$BranchesState {
  const factory BranchesState.initial() = BranchesInitial;
  const factory BranchesState.loading() = BranchesLoading;
  const factory BranchesState.loaded({
    required List<BranchModel> branches, @Default(false) bool isSubmitting,
  }) = BranchesLoaded;
  const factory BranchesState.failure({required String message}) = BranchesFailure;
}
