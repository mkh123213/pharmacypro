import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/stock_movement_model.dart';

part 'stock_movements_state.freezed.dart';

@freezed
class StockMovementsState with _$StockMovementsState {
  const factory StockMovementsState.initial() = StockMovementsInitial;

  const factory StockMovementsState.loading() = StockMovementsLoading;

  const factory StockMovementsState.loaded({
    required List<StockMovementModel> movements,
    required List<StockMovementModel> filteredMovements,
    @Default('') String searchQuery,
    @Default('all') String selectedType,
  }) = StockMovementsLoaded;

  const factory StockMovementsState.failure({required String message}) =
      StockMovementsFailure;
}
