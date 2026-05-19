import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/inventory_alert_model.dart';
import '../../data/repos/inventory_repo.dart';
import 'inventory_alerts_state.dart';

class InventoryAlertsCubit extends Cubit<InventoryAlertsState> {
  InventoryAlertsCubit({required InventoryRepo inventoryRepo})
    : _inventoryRepo = inventoryRepo,
      super(const InventoryAlertsState.initial());

  final InventoryRepo _inventoryRepo;

  List<InventoryAlertModel> _allAlerts = [];
  String _selectedType = 'all';
  String _searchQuery = '';

  Future<void> getInventoryAlerts() async {
    emit(const InventoryAlertsState.loading());

    try {
      _allAlerts = await _inventoryRepo.getInventoryAlerts();

      emit(
        InventoryAlertsState.loaded(
          alerts: _allAlerts,
          filteredAlerts: _filteredAlerts,
          selectedType: _selectedType,
          searchQuery: _searchQuery,
        ),
      );
    } catch (error) {
      emit(
        const InventoryAlertsState.failure(
          message: 'could_not_load_inventory_alerts',
        ),
      );
    }
  }

  void updateSelectedType(String value) {
    _selectedType = value;
    _emitLoaded();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  List<InventoryAlertModel> get _filteredAlerts {
    final query = _searchQuery.toLowerCase().trim();

    return _allAlerts.where((alert) {
      final item = alert.inventoryItem;

      final matchesType = _selectedType == 'all' || alert.type == _selectedType;

      final matchesSearch =
          (item.medicationName?.toLowerCase().contains(query) ?? false) ||
          (item.branchName?.toLowerCase().contains(query) ?? false) ||
          (item.batchNumber?.toLowerCase().contains(query) ?? false) ||
          alert.type.toLowerCase().contains(query);

      return matchesType && matchesSearch;
    }).toList();
  }

  void _emitLoaded() {
    final current = state;

    if (current is InventoryAlertsLoaded) {
      emit(
        current.copyWith(
          alerts: _allAlerts,
          filteredAlerts: _filteredAlerts,
          selectedType: _selectedType,
          searchQuery: _searchQuery,
        ),
      );
    }
  }
}
