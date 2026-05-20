import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/dashboard_summary_model.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;

  const factory DashboardState.loading() = DashboardLoading;

  const factory DashboardState.loaded({
    required DashboardSummaryModel summary,
    @Default(false) bool isRefreshing,
    @Default(null) String? errorMessage,
  }) = DashboardLoaded;

  const factory DashboardState.failure({required String message}) =
      DashboardFailure;
}
