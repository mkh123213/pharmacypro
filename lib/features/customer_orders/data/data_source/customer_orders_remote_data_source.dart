import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/customer_order_model.dart';

class CustomerOrdersRemoteDataSource {
  CustomerOrdersRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _orders => _firestore.collection('customer_orders');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');
  CollectionReference<Map<String, dynamic>> get _medications => _firestore.collection('medications');

  Future<List<CustomerOrderModel>> getCustomerOrders() async {
    final snapshot = await _orders.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(CustomerOrderModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();
    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();
    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<CustomerOrderModel> createCustomerOrder(CustomerOrderModel item) async {
    final document = await _orders.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return CustomerOrderModel.fromFirestore(await document.get());
  }

  Future<void> updateCustomerOrderFields(String id, Map<String, dynamic> data) async {
    await _orders.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
