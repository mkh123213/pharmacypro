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
    } catch (error) {
      emit(const ReportsState.failure(message: 'could_not_load_reports'));
    }
  }

  Future<void> refreshReports() async {
    try {
      final result = await _repo.getReports(branchId: _branchId);

      emit(
        ReportsState.loaded(
          summary: result.summary,
          branches: result.branches,
          selectedBranchId: _branchId,
        ),
      );
    } catch (error) {
      emit(const ReportsState.failure(message: 'could_not_refresh_reports'));
    }
  }

  Future<void> updateBranch(String value) async {
    _branchId = value;
    await getReports();
  }
}
