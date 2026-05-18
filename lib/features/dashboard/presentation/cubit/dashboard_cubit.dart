import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/dashboard_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required DashboardRepo dashboardRepo}) : _dashboardRepo = dashboardRepo, super(const DashboardState.initial());
  final DashboardRepo _dashboardRepo;
  Future<void> getDashboardSummary() async { emit(const DashboardState.loading()); try { emit(DashboardState.loaded(summary: await _dashboardRepo.getDashboardSummary())); } catch (e) { emit(DashboardState.failure(message: e.toString())); } }
}
