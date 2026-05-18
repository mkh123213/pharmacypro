import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../branches/data/models/branch_model.dart';
import '../models/prescription_model.dart';

class PrescriptionsRemoteDataSource {
  PrescriptionsRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _prescriptions => _firestore.collection('prescriptions');
  CollectionReference<Map<String, dynamic>> get _branches => _firestore.collection('branches');

  Future<List<PrescriptionModel>> getPrescriptions() async {
    final snapshot = await _prescriptions.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(PrescriptionModel.fromFirestore).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _branches.get();
    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<PrescriptionModel> createPrescription(PrescriptionModel item) async {
    final document = await _prescriptions.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    return PrescriptionModel.fromFirestore(await document.get());
  }

  Future<void> updatePrescriptionFields(String id, Map<String, dynamic> data) async {
    await _prescriptions.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
