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
  String _selectedStockStatus = 'all';

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
          selectedStockStatus: _selectedStockStatus,
          errorMessage: null,
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

  void updateSelectedStockStatus(String value) {
    _selectedStockStatus = value;
    _emitFromLoaded();
  }

  Future<bool> createInventory(InventoryModel item) async {
    final current = state;

    if (current is! InventoryLoaded) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _inventoryRepo.createInventory(item);

      _allInventory = [created, ...oldInventory];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allInventory = oldInventory;

      emit(
        current.copyWith(
          inventory: _filteredInventory,
          isSubmitting: false,
          errorMessage: _inventoryErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateInventory(InventoryModel item) async {
    final current = state;

    if (current is! InventoryLoaded) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

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
        current.copyWith(
          inventory: _filteredInventory,
          isSubmitting: false,
          errorMessage: _inventoryErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> adjustInventoryStock({
    required InventoryModel item,
    required int quantityChange,
    required String reason,
  }) async {
    final current = state;

    if (current is! InventoryLoaded) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _inventoryRepo.adjustInventoryStock(
        item: item,
        quantityChange: quantityChange,
        reason: reason,
      );

      _allInventory = oldInventory.map((entry) {
        return entry.id == updated.id ? updated : entry;
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allInventory = oldInventory;

      emit(
        current.copyWith(
          inventory: _filteredInventory,
          isSubmitting: false,
          errorMessage: _inventoryErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _inventoryErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('duplicate_inventory_item')) {
      return 'duplicate_inventory_item';
    }

    if (text.contains('inventory_item_not_found')) {
      return 'inventory_item_not_found';
    }

    if (text.contains('quantity_cannot_go_below_zero')) {
      return 'quantity_cannot_go_below_zero';
    }

    if (text.contains('inventory_missing_medication')) {
      return 'inventory_missing_medication';
    }

    if (text.contains('inventory_missing_branch')) {
      return 'inventory_missing_branch';
    }

    if (text.contains('inventory_invalid_quantity')) {
      return 'inventory_invalid_quantity';
    }

    if (text.contains('inventory_invalid_min_stock_level')) {
      return 'inventory_invalid_min_stock_level';
    }

    if (text.contains('inventory_invalid_expiry_date')) {
      return 'inventory_invalid_expiry_date';
    }

    if (text.contains('inventory_adjustment_quantity_required')) {
      return 'inventory_adjustment_quantity_required';
    }

    if (text.contains('inventory_adjustment_reason_required')) {
      return 'inventory_adjustment_reason_required';
    }

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    if (text.contains('medication_not_found')) {
      return 'medication_not_found';
    }

    if (text.contains('inactive_medication')) {
      return 'inactive_medication';
    }

    return 'could_not_save_inventory_item';
  }

  Future<bool> deleteInventoryItem(String id) async {
    final current = state;

    if (current is! InventoryLoaded || current.isSubmitting) return false;

    final oldInventory = List<InventoryModel>.from(_allInventory);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _inventoryRepo.deleteInventoryItem(id);

      _allInventory = oldInventory.where((item) => item.id != id).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allInventory = oldInventory;

      emit(
        current.copyWith(
          inventory: _filteredInventory,
          isSubmitting: false,
          errorMessage: 'could_not_delete_inventory_item',
        ),
      );

      return false;
    }
  }

  List<InventoryModel> get _filteredInventory {
    final query = _searchQuery.toLowerCase().trim();

    return _allInventory.where((item) {
      final matchSearch =
          query.isEmpty ||
          (item.medicationName?.toLowerCase().contains(query) ?? false) ||
          (item.branchName?.toLowerCase().contains(query) ?? false) ||
          (item.batchNumber?.toLowerCase().contains(query) ?? false) ||
          (item.locationInStore?.toLowerCase().contains(query) ?? false);

      final matchBranch =
          _selectedBranchId == 'all' || item.branchId == _selectedBranchId;

      final matchStockStatus =
          _selectedStockStatus == 'all' ||
          (_selectedStockStatus == 'low_stock' && item.isLowStock) ||
          (_selectedStockStatus == 'expired' && item.isExpired) ||
          (_selectedStockStatus == 'expiring_soon' && item.isExpiringSoon) ||
          (_selectedStockStatus == 'healthy' &&
              !item.isLowStock &&
              !item.isExpired &&
              !item.isExpiringSoon);

      return matchSearch && matchBranch && matchStockStatus;
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
          selectedStockStatus: _selectedStockStatus,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
