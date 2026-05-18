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
      emit(BranchesState.failure(message: error.toString()));
    }
  }

  Future<void> createBranch(BranchModel branch) async {
    if (state is BranchesLoaded) {
      emit((state as BranchesLoaded).copyWith(isSubmitting: true));
    }
    try {
      final created = await _branchesRepo.createBranch(branch);
      _branches = [created, ..._branches];
      emit(BranchesState.loaded(branches: _branches));
    } catch (error) {
      emit(BranchesState.failure(message: error.toString()));
    }
  }

  Future<void> updateBranch(BranchModel branch) async {
    if (state is BranchesLoaded) {
      emit((state as BranchesLoaded).copyWith(isSubmitting: true));
    }
    try {
      final updated = await _branchesRepo.updateBranch(branch);
      _branches = _branches.map((item) => item.id == updated.id ? updated : item).toList();
      emit(BranchesState.loaded(branches: _branches));
    } catch (error) {
      emit(BranchesState.failure(message: error.toString()));
    }
  }
}
