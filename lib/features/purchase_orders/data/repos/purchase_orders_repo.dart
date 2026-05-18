import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../data_source/purchase_orders_remote_data_source.dart';
import '../models/purchase_order_model.dart';

class PurchaseOrdersRepo {
  const PurchaseOrdersRepo({required PurchaseOrdersRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final PurchaseOrdersRemoteDataSource _remoteDataSource;

  Future<List<PurchaseOrderModel>> getPurchaseOrders() => _remoteDataSource.getPurchaseOrders();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<MedicationModel>> getMedications() => _remoteDataSource.getMedications();
  Future<List<SupplierModel>> getSuppliers() => _remoteDataSource.getSuppliers();
  Future<PurchaseOrderModel> createPurchaseOrder(PurchaseOrderModel item) => _remoteDataSource.createPurchaseOrder(item);
  Future<void> updatePurchaseOrderFields(String id, Map<String, dynamic> data) => _remoteDataSource.updatePurchaseOrderFields(id, data);
}
