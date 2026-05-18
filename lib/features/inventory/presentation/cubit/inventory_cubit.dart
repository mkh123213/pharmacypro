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

      emit(
        InventoryState.loaded(
          inventory: _filteredInventory,
          medications: results[1] as dynamic,
          branches: results[2] as dynamic,
          searchQuery: _searchQuery,
          selectedBranchId: _selectedBranchId,
        ),
      );
    } catch (error) {
      emit(const InventoryState.failure(message: 'could_not_load_inventory'));
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

  Future<bool> createInventory(InventoryModel item) async {
    final current = state;

    if (current is! InventoryLoaded) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true));

    try {
      final created = await _inventoryRepo.createInventory(item);

      _allInventory = [created, ...oldInventory];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allInventory = oldInventory;

      emit(
        current.copyWith(inventory: _filteredInventory, isSubmitting: false),
      );

      return false;
    }
  }

  Future<bool> updateInventory(InventoryModel item) async {
    final current = state;

    if (current is! InventoryLoaded) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true));

    try {
      final updated = await _inventoryRepo.updateInventory(item);

      _allInventory = oldInventory.map((entry) {
        return entry.id == updated.id ? updated : entry;
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allInventory = oldInventory;

      emit(
        current.copyWith(inventory: _filteredInventory, isSubmitting: false),
      );

      return false;
    }
  }

  List<InventoryModel> get _filteredInventory {
    final query = _searchQuery.toLowerCase().trim();

    return _allInventory.where((item) {
      final matchSearch =
          (item.medicationName?.toLowerCase().contains(query) ?? false) ||
          (item.branchName?.toLowerCase().contains(query) ?? false) ||
          (item.batchNumber?.toLowerCase().contains(query) ?? false);

      final matchBranch =
          _selectedBranchId == 'all' || item.branchId == _selectedBranchId;

      return matchSearch && matchBranch;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is InventoryLoaded) {
      emit(
        current.copyWith(
          inventory: _filteredInventory,
          searchQuery: _searchQuery,
          selectedBranchId: _selectedBranchId,
          isSubmitting: false,
        ),
      );
    }
  }
}
