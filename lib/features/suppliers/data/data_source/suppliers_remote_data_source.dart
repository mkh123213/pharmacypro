import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/supplier_model.dart';

class SuppliersRemoteDataSource {
  SuppliersRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  CollectionReference<Map<String, dynamic>> get _collection => _firestore.collection('suppliers');

  Future<List<SupplierModel>> getSuppliers() async {
    final snapshot = await _collection.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(SupplierModel.fromFirestore).toList();
  }

  Future<SupplierModel> createSupplier(SupplierModel supplier) async {
    final doc = await _collection.add({...supplier.toFirestoreJson(), 'created_at': FieldValue.serverTimestamp(), 'updated_at': FieldValue.serverTimestamp()});
    return SupplierModel.fromFirestore(await doc.get());
  }

  Future<SupplierModel> updateSupplier(SupplierModel supplier) async {
    await _collection.doc(supplier.id).update({...supplier.toFirestoreJson(), 'updated_at': FieldValue.serverTimestamp()});
    return SupplierModel.fromFirestore(await _collection.doc(supplier.id).get());
  }
}
