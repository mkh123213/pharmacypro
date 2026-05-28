import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/reports_repo.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit({required ReportsRepo reportsRepo})
    : _repo = reportsRepo,
      super(const ReportsState.initial());

  final ReportsRepo _repo;

  String _branchId = 'all';

  Future<void> getReports() async {
    emit(const ReportsState.loading());

    try {
      final result = await _repo.getReports(branchId: _branchId);

      emit(
        ReportsState.loaded(
          summary: result.summary,
          branches: result.branches,
          selectedBranchId: _branchId,
        ),
      );
    } catch (_) {
      emit(const ReportsState.failure(message: 'could_not_load_reports'));
    }
  }

  Future<void> refreshReports() async {
    final current = state;

    if (current is ReportsLoaded) {
      emit(current.copyWith(isRefreshing: true, errorMessage: null));

      try {
        final result = await _repo.getReports(branchId: _branchId);

        emit(
          ReportsState.loaded(
            summary: result.summary,
            branches: result.branches,
            selectedBranchId: _branchId,
          ),
        );
      } catch (_) {
        emit(
          current.copyWith(
            isRefreshing: false,
            errorMessage: 'could_not_refresh_reports',
          ),
        );
      }

      return;
    }

    await getReports();
  }

  Future<void> updateBranch(String value) async {
    if (_branchId == value) return;

    _branchId = value;

    final current = state;

    if (current is ReportsLoaded) {
      emit(
        current.copyWith(
          selectedBranchId: value,
          isRefreshing: true,
          errorMessage: null,
        ),
      );

      try {
        final result = await _repo.getReports(branchId: _branchId);

        emit(
          ReportsState.loaded(
            summary: result.summary,
            branches: result.branches,
            selectedBranchId: _branchId,
          ),
        );
      } catch (_) {
        emit(
          current.copyWith(
            selectedBranchId: current.selectedBranchId,
            isRefreshing: false,
            errorMessage: 'could_not_load_reports',
          ),
        );
      }

      return;
    }

    await getReports();
  }
}
