import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/branch_model.dart';
import '../../data/repos/branches_repo.dart';
import 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit({required BranchesRepo branchesRepo})
    : _branchesRepo = branchesRepo,
      super(const BranchesState.initial());

  final BranchesRepo _branchesRepo;

  List<BranchModel> _allBranches = [];
  String _searchQuery = '';
  String _selectedStatus = 'all';

  Future<void> getBranches() async {
    emit(const BranchesState.loading());

    try {
      _allBranches = await _branchesRepo.getBranches();

      emit(
        BranchesState.loaded(
          branches: _filteredBranches,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(const BranchesState.failure(message: 'could_not_load_branches'));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  void updateSelectedStatus(String value) {
    _selectedStatus = value;
    _emitFromLoaded();
  }

  Future<bool> createBranch(BranchModel branch) async {
    final current = state;

    if (current is! BranchesLoaded) return false;

    final oldBranches = List<BranchModel>.from(_allBranches);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _branchesRepo.createBranch(
        branch.copyWith(name: branch.name.trim()),
      );

      _allBranches = [created, ...oldBranches];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allBranches = oldBranches;

      emit(
        current.copyWith(
          branches: _filteredBranches,
          isSubmitting: false,
          errorMessage: _branchErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateBranch(BranchModel branch) async {
    final current = state;

    if (current is! BranchesLoaded) return false;

    final oldBranches = List<BranchModel>.from(_allBranches);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _branchesRepo.updateBranch(
        branch.copyWith(name: branch.name.trim()),
      );

      _allBranches = oldBranches.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allBranches = oldBranches;

      emit(
        current.copyWith(
          branches: _filteredBranches,
          isSubmitting: false,
          errorMessage: _branchErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _branchErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('branch_name_required')) {
      return 'branch_name_required';
    }

    if (text.contains('branch_address_required')) {
      return 'branch_address_required';
    }

    if (text.contains('branch_invalid_phone')) {
      return 'branch_invalid_phone';
    }

    if (text.contains('branch_invalid_email')) {
      return 'branch_invalid_email';
    }

    if (text.contains('branch_name_already_exists')) {
      return 'branch_name_already_exists';
    }

    return 'could_not_save_branch';
  }

  List<BranchModel> get _filteredBranches {
    final query = _searchQuery.toLowerCase().trim();

    return _allBranches.where((branch) {
      final matchSearch =
          query.isEmpty ||
          branch.name.toLowerCase().contains(query) ||
          branch.address.toLowerCase().contains(query) ||
          (branch.city?.toLowerCase().contains(query) ?? false) ||
          (branch.phone?.toLowerCase().contains(query) ?? false) ||
          (branch.email?.toLowerCase().contains(query) ?? false) ||
          (branch.managerName?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == 'all' ||
          (_selectedStatus == 'active' && branch.isActive) ||
          (_selectedStatus == 'inactive' && !branch.isActive);

      return matchSearch && matchStatus;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is BranchesLoaded) {
      emit(
        current.copyWith(
          branches: _filteredBranches,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
