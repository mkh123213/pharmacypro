import '../data_source/suppliers_remote_data_source.dart';
import '../models/supplier_model.dart';

class SuppliersRepo {
  const SuppliersRepo({required SuppliersRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SuppliersRemoteDataSource _remoteDataSource;

  Future<List<SupplierModel>> getSuppliers() {
    return _remoteDataSource.getSuppliers();
  }

  Future<SupplierModel> createSupplier(SupplierModel supplier) {
    return _remoteDataSource.createSupplier(supplier);
  }

  Future<SupplierModel> updateSupplier(SupplierModel supplier) {
    return _remoteDataSource.updateSupplier(supplier);
  }

  Future<void> deleteSupplier(String id) {
    return _remoteDataSource.deleteSupplier(id);
  }
}
