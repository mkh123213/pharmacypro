import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/reports_repo.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState>{ReportsCubit({required ReportsRepo reportsRepo}):_repo=reportsRepo,super(const ReportsState.initial());final ReportsRepo _repo;String _branchId='all';Future<void> getReports()async{emit(const ReportsState.loading());try{final r=await _repo.getReports(branchId:_branchId);emit(ReportsState.loaded(summary:r.summary,branches:r.branches,selectedBranchId:_branchId));}catch(e){emit(ReportsState.failure(message:e.toString()));}}Future<void> updateBranch(String value)async{_branchId=value;await getReports();}}
