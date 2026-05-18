import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/inventory_remote_data_source.dart';
import '../models/inventory_model.dart';

class InventoryRepo {
  const InventoryRepo({required InventoryRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final InventoryRemoteDataSource _remoteDataSource;

  Future<List<InventoryModel>> getInventory() => _remoteDataSource.getInventory();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<MedicationModel>> getMedications() => _remoteDataSource.getMedications();
  Future<InventoryModel> createInventory(InventoryModel item) => _remoteDataSource.createInventory(item);
  Future<InventoryModel> updateInventory(InventoryModel item) => _remoteDataSource.updateInventory(item);
}
