import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../models/sale_model.dart';

class SalesRemoteDataSource {
  SalesRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _sales => _firestore.collection('sales');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');
  CollectionReference<Map<String, dynamic>> get _medications => _firestore.collection('medications');

  Future<List<SaleModel>> getSales() async {
    final snapshot = await _sales.orderBy('created_at', descending: true).limit(100).get();
    return snapshot.docs.map(SaleModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();
    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _medications.get();
    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<SaleModel> createSale(SaleModel item) async {
    final document = await _sales.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return SaleModel.fromFirestore(await document.get());
  }
}
