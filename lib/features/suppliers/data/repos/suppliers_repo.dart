import '../data_source/suppliers_remote_data_source.dart';
import '../models/supplier_model.dart';

class SuppliersRepo {
  const SuppliersRepo({required SuppliersRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;
  final SuppliersRemoteDataSource _remoteDataSource;
  Future<List<SupplierModel>> getSuppliers() => _remoteDataSource.getSuppliers();
  Future<SupplierModel> createSupplier(SupplierModel supplier) => _remoteDataSource.createSupplier(supplier);
  Future<SupplierModel> updateSupplier(SupplierModel supplier) => _remoteDataSource.updateSupplier(supplier);
}
