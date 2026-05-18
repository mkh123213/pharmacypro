import '../data_source/dashboard_remote_data_source.dart';
import '../models/dashboard_summary_model.dart';

class DashboardRepo {
  const DashboardRepo({required DashboardRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;
  final DashboardRemoteDataSource _remoteDataSource;
  Future<DashboardSummaryModel> getDashboardSummary() => _remoteDataSource.getDashboardSummary();
}
