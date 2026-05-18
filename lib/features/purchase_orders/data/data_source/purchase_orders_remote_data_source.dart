import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../models/purchase_order_model.dart';

class PurchaseOrdersRemoteDataSource {
  PurchaseOrdersRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _orders => _firestore.collection('purchase_orders');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');
  CollectionReference<Map<String, dynamic>> get _medications => _firestore.collection('medications');
  CollectionReference<Map<String, dynamic>> get _suppliers => _firestore.collection('suppliers');

  Future<List<PurchaseOrderModel>> getPurchaseOrders() async {
    final snapshot = await _orders.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(PurchaseOrderModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async => (await _branches.get()).docs.map(BranchModel.fromFirestore).toList();
  Future<List<MedicationModel>> getMedications() async => (await _medications.get()).docs.map(MedicationModel.fromFirestore).toList();
  Future<List<SupplierModel>> getSuppliers() async => (await _suppliers.get()).docs.map(SupplierModel.fromFirestore).toList();

  Future<PurchaseOrderModel> createPurchaseOrder(PurchaseOrderModel item) async {
    final document = await _orders.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return PurchaseOrderModel.fromFirestore(await document.get());
  }

  Future<void> updatePurchaseOrderFields(String id, Map<String, dynamic> data) async {
    await _orders.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
