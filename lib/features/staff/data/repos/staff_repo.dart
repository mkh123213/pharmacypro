import '../../../branches/data/models/branch_model.dart';
import '../data_source/staff_remote_data_source.dart';
import '../models/staff_model.dart';

class StaffRepo {
  const StaffRepo({required StaffRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final StaffRemoteDataSource _remoteDataSource;

  Future<List<StaffModel>> getStaff() {
    return _remoteDataSource.getStaff();
  }

  Future<List<BranchModel>> getBranches() {
    return _remoteDataSource.getBranches();
  }

  Future<StaffModel> createStaff(StaffModel item, {required String password}) {
    return _remoteDataSource.createStaff(item, password: password);
  }

  Future<StaffModel> updateStaff(StaffModel item) {
    return _remoteDataSource.updateStaff(item);
  }

  Future<void> deleteStaff(String id) {
    return _remoteDataSource.deleteStaff(id);
  }
}
