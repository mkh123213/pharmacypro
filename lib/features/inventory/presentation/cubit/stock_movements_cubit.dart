import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/stock_movement_model.dart';
import '../../data/repos/inventory_repo.dart';
import 'stock_movements_state.dart';

class StockMovementsCubit extends Cubit<StockMovementsState> {
  StockMovementsCubit({required InventoryRepo inventoryRepo})
    : _inventoryRepo = inventoryRepo,
      super(const StockMovementsState.initial());

  final InventoryRepo _inventoryRepo;

  List<StockMovementModel> _allMovements = [];
  String _searchQuery = '';
  String _selectedType = 'all';

  Future<void> getStockMovements() async {
    emit(const StockMovementsState.loading());

    try {
      _allMovements = await _inventoryRepo.getStockMovements();

      emit(
        StockMovementsState.loaded(
          movements: _allMovements,
          filteredMovements: _filteredMovements,
          searchQuery: _searchQuery,
          selectedType: _selectedType,
        ),
      );
    } catch (error) {
      emit(
        const StockMovementsState.failure(
          message: 'could_not_load_stock_movements',
        ),
      );
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  void updateSelectedType(String value) {
    _selectedType = value;
    _emitLoaded();
  }

  List<StockMovementModel> get _filteredMovements {
    final query = _searchQuery.toLowerCase().trim();

    return _allMovements.where((movement) {
      final matchesSearch =
          (movement.medicationName?.toLowerCase().contains(query) ?? false) ||
          (movement.branchName?.toLowerCase().contains(query) ?? false) ||
          (movement.reason?.toLowerCase().contains(query) ?? false) ||
          movement.type.toLowerCase().contains(query);

      final matchesType =
          _selectedType == 'all' || movement.type == _selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  void _emitLoaded() {
    final current = state;

    if (current is StockMovementsLoaded) {
      emit(
        current.copyWith(
          movements: _allMovements,
          filteredMovements: _filteredMovements,
          searchQuery: _searchQuery,
          selectedType: _selectedType,
        ),
      );
    }
  }
}
