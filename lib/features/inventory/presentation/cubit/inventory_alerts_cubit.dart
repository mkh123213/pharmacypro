import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/inventory_alert_model.dart';
import '../../data/models/inventory_model.dart';
import '../../data/repos/inventory_repo.dart';
import '../refactor/inventory_alert_filter_values.dart';
import 'inventory_alerts_state.dart';

class InventoryAlertsCubit extends Cubit<InventoryAlertsState> {
  InventoryAlertsCubit({required InventoryRepo inventoryRepo})
    : _inventoryRepo = inventoryRepo,
      super(const InventoryAlertsState.initial());

  final InventoryRepo _inventoryRepo;

  List<InventoryAlertModel> _allAlerts = [];
  String _selectedType = InventoryAlertFilterValues.all;
  String _searchQuery = '';

  Future<void> getInventoryAlerts({String? initialType}) async {
    _selectedType = InventoryAlertFilterValues.normalize(
      initialType ?? _selectedType,
    );

    emit(const InventoryAlertsState.loading());

    try {
      _allAlerts = await _inventoryRepo.getInventoryAlerts();

      emit(
        InventoryAlertsState.loaded(
          alerts: _allAlerts,
          filteredAlerts: _filteredAlerts,
          selectedType: _selectedType,
          searchQuery: _searchQuery,
          errorMessage: null,
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
    _selectedType = InventoryAlertFilterValues.normalize(value);
    _emitLoaded();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  Future<bool> removeExpiredStock({
    required InventoryModel item,
    required String reason,
  }) async {
    final current = state;

    if (current is! InventoryAlertsLoaded) return false;

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _inventoryRepo.removeExpiredStock(item: item, reason: reason);

      _allAlerts = await _inventoryRepo.getInventoryAlerts();

      emit(
        current.copyWith(
          alerts: _allAlerts,
          filteredAlerts: _filteredAlerts,
          selectedType: _selectedType,
          searchQuery: _searchQuery,
          isSubmitting: false,
          errorMessage: null,
        ),
      );

      return true;
    } catch (error) {
      emit(
        current.copyWith(
          isSubmitting: false,
          errorMessage: _inventoryAlertErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _inventoryAlertErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('inventory_item_not_found')) {
      return 'inventory_item_not_found';
    }

    if (text.contains('expired_stock_quantity_already_zero')) {
      return 'expired_stock_quantity_already_zero';
    }

    return 'could_not_remove_expired_stock';
  }

  List<InventoryAlertModel> get _filteredAlerts {
    final query = _searchQuery.toLowerCase().trim();

    return _allAlerts.where((alert) {
      final item = alert.inventoryItem;

      final matchesType =
          _selectedType == InventoryAlertFilterValues.all ||
          alert.type == _selectedType;

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
