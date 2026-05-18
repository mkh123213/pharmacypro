import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/inventory_model.dart';
import '../../data/repos/inventory_repo.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit({required InventoryRepo inventoryRepo})
      : _inventoryRepo = inventoryRepo,
        super(const InventoryState.initial());

  final InventoryRepo _inventoryRepo;
  List<InventoryModel> _allInventory = [];
  String _searchQuery = '';
  String _selectedBranchId = 'all';

  Future<void> getInventoryData() async {
    emit(const InventoryState.loading());
    try {
      final results = await Future.wait([
        _inventoryRepo.getInventory(),
        _inventoryRepo.getMedications(),
        _inventoryRepo.getBranches(),
      ]);
      _allInventory = results[0] as List<InventoryModel>;
      emit(InventoryState.loaded(
        inventory: _filteredInventory,
        medications: results[1] as dynamic,
        branches: results[2] as dynamic,
        searchQuery: _searchQuery,
        selectedBranchId: _selectedBranchId,
      ));
    } catch (error) {
      emit(InventoryState.failure(message: error.toString()));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  void updateSelectedBranch(String value) {
    _selectedBranchId = value;
    _emitFromLoaded();
  }

  Future<void> createInventory(InventoryModel item) async {
    if (state is InventoryLoaded) emit((state as InventoryLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _inventoryRepo.createInventory(item);
      _allInventory = [created, ..._allInventory];
      _emitFromLoaded();
    } catch (error) {
      emit(InventoryState.failure(message: error.toString()));
    }
  }

  Future<void> updateInventory(InventoryModel item) async {
    if (state is InventoryLoaded) emit((state as InventoryLoaded).copyWith(isSubmitting: true));
    try {
      final updated = await _inventoryRepo.updateInventory(item);
      _allInventory = _allInventory.map((entry) => entry.id == updated.id ? updated : entry).toList();
      _emitFromLoaded();
    } catch (error) {
      emit(InventoryState.failure(message: error.toString()));
    }
  }

  List<InventoryModel> get _filteredInventory {
    final query = _searchQuery.toLowerCase();
    return _allInventory.where((item) {
      final matchSearch = (item.medicationName?.toLowerCase().contains(query) ?? false) ||
          (item.branchName?.toLowerCase().contains(query) ?? false);
      final matchBranch = _selectedBranchId == 'all' || item.branchId == _selectedBranchId;
      return matchSearch && matchBranch;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is InventoryLoaded) {
      emit(current.copyWith(
        inventory: _filteredInventory,
        searchQuery: _searchQuery,
        selectedBranchId: _selectedBranchId,
        isSubmitting: false,
      ));
    }
  }
}
