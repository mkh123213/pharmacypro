import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/medication_model.dart';

class MedicationsRemoteDataSource {
  MedicationsRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('medications');
  }

  Future<List<MedicationModel>> getMedications() async {
    final snapshot = await _collection
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<MedicationModel> createMedication(MedicationModel item) async {
    final normalizedName = _normalizeText(item.name);
    final normalizedBarcode = _normalizeText(item.barcode);

    final duplicateNameQuery = await _collection
        .where('name_search', isEqualTo: normalizedName)
        .limit(1)
        .get();

    if (duplicateNameQuery.docs.isNotEmpty) {
      throw Exception('duplicate_medication_name');
    }

    if (normalizedBarcode.isNotEmpty) {
      final duplicateBarcodeQuery = await _collection
          .where('barcode_search', isEqualTo: normalizedBarcode)
          .limit(1)
          .get();

      if (duplicateBarcodeQuery.docs.isNotEmpty) {
        throw Exception('duplicate_medication_barcode');
      }
    }

    final document = await _collection.add({
      ...item.toFirestoreJson(),
      'name_search': normalizedName,
      'barcode_search': normalizedBarcode.isEmpty ? null : normalizedBarcode,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    final snapshot = await document.get();

    return MedicationModel.fromFirestore(snapshot);
  }

  Future<MedicationModel> updateMedication(MedicationModel item) async {
    final normalizedName = _normalizeText(item.name);
    final normalizedBarcode = _normalizeText(item.barcode);

    final duplicateNameQuery = await _collection
        .where('name_search', isEqualTo: normalizedName)
        .limit(5)
        .get();

    final hasDuplicateName = duplicateNameQuery.docs.any((document) {
      return document.id != item.id;
    });

    if (hasDuplicateName) {
      throw Exception('duplicate_medication_name');
    }

    if (normalizedBarcode.isNotEmpty) {
      final duplicateBarcodeQuery = await _collection
          .where('barcode_search', isEqualTo: normalizedBarcode)
          .limit(5)
          .get();

      final hasDuplicateBarcode = duplicateBarcodeQuery.docs.any((document) {
        return document.id != item.id;
      });

      if (hasDuplicateBarcode) {
        throw Exception('duplicate_medication_barcode');
      }
    }

    await _collection.doc(item.id).update({
      ...item.toFirestoreJson(),
      'name_search': normalizedName,
      'barcode_search': normalizedBarcode.isEmpty ? null : normalizedBarcode,
      'updated_at': FieldValue.serverTimestamp(),
    });

    final snapshot = await _collection.doc(item.id).get();

    return MedicationModel.fromFirestore(snapshot);
  }

  Future<void> updateMedicationFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _collection.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  String _normalizeText(Object? value) {
    return value.toString().trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
  }
}
