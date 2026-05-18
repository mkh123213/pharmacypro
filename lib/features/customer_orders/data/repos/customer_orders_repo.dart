import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/customer_orders_remote_data_source.dart';
import '../models/customer_order_model.dart';

class CustomerOrdersRepo {
  const CustomerOrdersRepo({required CustomerOrdersRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final CustomerOrdersRemoteDataSource _remoteDataSource;

  Future<List<CustomerOrderModel>> getCustomerOrders() => _remoteDataSource.getCustomerOrders();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<MedicationModel>> getMedications() => _remoteDataSource.getMedications();
  Future<CustomerOrderModel> createCustomerOrder(CustomerOrderModel item) => _remoteDataSource.createCustomerOrder(item);
  Future<void> updateCustomerOrderFields(String id, Map<String, dynamic> data) => _remoteDataSource.updateCustomerOrderFields(id, data);
}
