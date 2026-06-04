import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/sales_remote_data_source.dart';
import '../models/sale_model.dart';

class SalesRepo {
  const SalesRepo({required SalesRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SalesRemoteDataSource _remoteDataSource;

  Future<List<SaleModel>> getSales() {
    return _remoteDataSource.getSales();
  }

  Future<List<BranchModel>> getBranches() {
    return _remoteDataSource.getBranches();
  }

  Future<List<MedicationModel>> getMedications() {
    return _remoteDataSource.getMedications();
  }

  Future<SaleModel> createSale(SaleModel item) {
    return _remoteDataSource.createSale(item);
  }

  Future<void> deleteSale(String id) {
    return _remoteDataSource.deleteSale(id);
  }
}
