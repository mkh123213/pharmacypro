import '../data_source/branches_remote_data_source.dart';
import '../models/branch_model.dart';

class BranchesRepo {
  const BranchesRepo({required BranchesRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final BranchesRemoteDataSource _remoteDataSource;

  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();

  Future<BranchModel> createBranch(BranchModel item) => _remoteDataSource.createBranch(item);

  Future<BranchModel> updateBranch(BranchModel item) => _remoteDataSource.updateBranch(item);

  Future<void> updateBranchFields(String id, Map<String, dynamic> data) =>
      _remoteDataSource.updateBranchFields(id, data);
}
