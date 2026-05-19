import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/inventory_alert_model.dart';

part 'inventory_alerts_state.freezed.dart';

@freezed
class InventoryAlertsState with _$InventoryAlertsState {
  const factory InventoryAlertsState.initial() = InventoryAlertsInitial;

  const factory InventoryAlertsState.loading() = InventoryAlertsLoading;

  const factory InventoryAlertsState.loaded({
    required List<InventoryAlertModel> alerts,
    required List<InventoryAlertModel> filteredAlerts,
    @Default('all') String selectedType,
    @Default('') String searchQuery,
  }) = InventoryAlertsLoaded;

  const factory InventoryAlertsState.failure({required String message}) =
      InventoryAlertsFailure;
}
