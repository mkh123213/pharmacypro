import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/branch_model.dart';
import '../../data/repos/branches_repo.dart';
import 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit({required BranchesRepo branchesRepo})
    : _branchesRepo = branchesRepo,
      super(const BranchesState.initial());

  final BranchesRepo _branchesRepo;

  List<BranchModel> _branches = [];

  Future<void> getBranches() async {
    emit(const BranchesState.loading());

    try {
      _branches = await _branchesRepo.getBranches();

      emit(BranchesState.loaded(branches: _branches));
    } catch (error) {
      emit(const BranchesState.failure(message: 'could_not_load_branches'));
    }
  }

  Future<bool> createBranch(BranchModel branch) async {
    final oldBranches = state is BranchesLoaded
        ? (state as BranchesLoaded).branches
        : _branches;

    emit(BranchesState.loaded(branches: oldBranches, isSubmitting: true));

    try {
      final created = await _branchesRepo.createBranch(branch);

      _branches = [created, ...oldBranches];

      emit(BranchesState.loaded(branches: _branches));

      return true;
    } catch (error) {
      emit(BranchesState.loaded(branches: oldBranches));

      emit(const BranchesState.failure(message: 'could_not_save_branch'));

      return false;
    }
  }

  Future<bool> updateBranch(BranchModel branch) async {
    final oldBranches = state is BranchesLoaded
        ? (state as BranchesLoaded).branches
        : _branches;

    emit(BranchesState.loaded(branches: oldBranches, isSubmitting: true));

    try {
      final updated = await _branchesRepo.updateBranch(branch);

      _branches = oldBranches.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      emit(BranchesState.loaded(branches: _branches));

      return true;
    } catch (error) {
      emit(BranchesState.loaded(branches: oldBranches));

      emit(const BranchesState.failure(message: 'could_not_save_branch'));

      return false;
    }
  }
}
