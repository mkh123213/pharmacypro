import '../../../branches/data/models/branch_model.dart';
import '../data_source/reports_remote_data_source.dart';
import '../models/reports_summary_model.dart';

class ReportsRepo{const ReportsRepo({required ReportsRemoteDataSource remoteDataSource}):_remoteDataSource=remoteDataSource;final ReportsRemoteDataSource _remoteDataSource;Future<({ReportsSummaryModel summary,List<BranchModel> branches})> getReports({String branchId='all'})=>_remoteDataSource.getReports(branchId:branchId);}
