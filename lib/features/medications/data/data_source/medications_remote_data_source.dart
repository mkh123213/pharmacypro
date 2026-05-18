import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/medication_model.dart';

class MedicationsRemoteDataSource {
  MedicationsRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection => _firestore.collection('medications');

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _collection.orderBy('created_at', descending: true).get();
    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<MedicationModel> createMedication(MedicationModel item) async {
    final document = await _collection.add({
      ...item.toFirestoreJson(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    final snapshot = await document.get();
    return MedicationModel.fromFirestore(snapshot);
  }

  Future<MedicationModel> updateMedication(MedicationModel item) async {
    await _collection.doc(item.id).update({
      ...item.toFirestoreJson(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    final snapshot = await _collection.doc(item.id).get();
    return MedicationModel.fromFirestore(snapshot);
  }

  Future<void> updateMedicationFields(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
