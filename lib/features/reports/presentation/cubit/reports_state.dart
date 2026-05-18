import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/reports_summary_model.dart';
import '../../../branches/data/models/branch_model.dart';

part 'reports_state.freezed.dart';

@freezed
class ReportsState with _$ReportsState {
  const factory ReportsState.initial() = ReportsInitial;
  const factory ReportsState.loading() = ReportsLoading;
  const factory ReportsState.loaded({
    required ReportsSummaryModel summary,
    required List<BranchModel> branches,
    @Default('all') String selectedBranchId,
  }) = ReportsLoaded;
  const factory ReportsState.failure({required String message}) = ReportsFailure;
}
