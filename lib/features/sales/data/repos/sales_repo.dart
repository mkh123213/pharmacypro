import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/sales_remote_data_source.dart';
import '../models/sale_model.dart';

class SalesRepo {
  const SalesRepo({required SalesRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final SalesRemoteDataSource _remoteDataSource;

  Future<List<SaleModel>> getSales() => _remoteDataSource.getSales();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<MedicationModel>> getMedications() => _remoteDataSource.getMedications();
  Future<SaleModel> createSale(SaleModel item) => _remoteDataSource.createSale(item);
}
