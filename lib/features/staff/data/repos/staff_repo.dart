import '../../../branches/data/models/branch_model.dart';
import '../data_source/staff_remote_data_source.dart';
import '../models/staff_model.dart';

class StaffRepo {
  const StaffRepo({required StaffRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final StaffRemoteDataSource _remoteDataSource;

  Future<List<StaffModel>> getStaff() => _remoteDataSource.getStaff();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<StaffModel> createStaff(StaffModel item) => _remoteDataSource.createStaff(item);
  Future<StaffModel> updateStaff(StaffModel item) => _remoteDataSource.updateStaff(item);
}
