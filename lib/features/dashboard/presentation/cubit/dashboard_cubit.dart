import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/dashboard_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required DashboardRepo dashboardRepo})
    : _dashboardRepo = dashboardRepo,
      super(const DashboardState.initial());

  final DashboardRepo _dashboardRepo;

  Future<void> getDashboardSummary() async {
    emit(const DashboardState.loading());

    try {
      final summary = await _dashboardRepo.getDashboardSummary();

      emit(DashboardState.loaded(summary: summary));
    } catch (error) {
      emit(
        const DashboardState.failure(message: 'could_not_load_dashboard_data'),
      );
    }
  }

  Future<void> refreshDashboard() async {
    try {
      final summary = await _dashboardRepo.getDashboardSummary();

      emit(DashboardState.loaded(summary: summary));
    } catch (error) {
      emit(
        const DashboardState.failure(message: 'could_not_refresh_dashboard'),
      );
    }
  }
}
