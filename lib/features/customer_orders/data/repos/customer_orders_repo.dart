import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/customer_orders_remote_data_source.dart';
import '../models/customer_order_model.dart';

class CustomerOrdersRepo {
  const CustomerOrdersRepo({required CustomerOrdersRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final CustomerOrdersRemoteDataSource _remoteDataSource;

  Future<(List<CustomerOrderModel>, DocumentSnapshot?)> getCustomerOrders({
    DocumentSnapshot? startAfter,
  }) => _remoteDataSource.getCustomerOrders(startAfter: startAfter);
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<MedicationModel>> getMedications() => _remoteDataSource.getMedications();
  Future<CustomerOrderModel> createCustomerOrder(CustomerOrderModel item) => _remoteDataSource.createCustomerOrder(item);
  Future<void> updateCustomerOrderFields(String id, Map<String, dynamic> data) => _remoteDataSource.updateCustomerOrderFields(id, data);
  Future<void> deleteCustomerOrder(String id) => _remoteDataSource.deleteCustomerOrder(id);
}
