import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/medication_model.dart';

class MedicationsRemoteDataSource {
  MedicationsRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('medications');
  }

  static const int pageSize = 30;

  Future<List<MedicationModel>> getMedications({
    DocumentSnapshot? startAfter,
    int limit = pageSize,
  }) async {
    Query<Map<String, dynamic>> query = _collection
        .orderBy('created_at', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();

    return snapshot.docs.map(MedicationModel.fromFirestore).toList();
  }

  Future<MedicationModel> createMedication(MedicationModel item) async {
    final normalizedItem = _normalizedMedication(item);

    await _validateMedication(normalizedItem);

    final normalizedName = _normalizeSearchText(normalizedItem.name);
    final normalizedBarcode = _normalizeSearchText(normalizedItem.barcode);

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
      ...normalizedItem.toFirestoreJson(),
      'name_search': normalizedName,
      'barcode_search': normalizedBarcode.isEmpty ? null : normalizedBarcode,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    final snapshot = await document.get();

    return MedicationModel.fromFirestore(snapshot);
  }

  Future<MedicationModel> updateMedication(MedicationModel item) async {
    final reference = _collection.doc(item.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('medication_not_found');
    }

    final normalizedItem = _normalizedMedication(item);

    await _validateMedication(normalizedItem);

    final normalizedName = _normalizeSearchText(normalizedItem.name);
    final normalizedBarcode = _normalizeSearchText(normalizedItem.barcode);

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

    await reference.update({
      ...normalizedItem.toFirestoreJson(),
      'name_search': normalizedName,
      'barcode_search': normalizedBarcode.isEmpty ? null : normalizedBarcode,
      'updated_at': FieldValue.serverTimestamp(),
    });

    final updatedSnapshot = await reference.get();

    return MedicationModel.fromFirestore(updatedSnapshot);
  }

  Future<void> updateMedicationFields(
    String id,
    Map<String, dynamic> data,
  ) async {
    final snapshot = await _collection.doc(id).get();

    if (!snapshot.exists) {
      throw Exception('medication_not_found');
    }

    await _collection.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMedication(String id) async {
    final reference = _collection.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('medication_not_found');
    }

    await reference.delete();
  }

  Future<void> deleteAllMedications() async {
    final snapshot = await _collection.get();
    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> _validateMedication(MedicationModel item) async {
    if (item.name.trim().isEmpty) {
      throw Exception('medication_name_required');
    }

    if (item.price < 0) {
      throw Exception('medication_invalid_price');
    }

    if (item.costPrice != null && item.costPrice! < 0) {
      throw Exception('medication_invalid_cost_price');
    }

    if (item.category != null && !_validCategories.contains(item.category)) {
      throw Exception('medication_invalid_category');
    }

    if (item.dosageForm != null && !_validForms.contains(item.dosageForm)) {
      throw Exception('medication_invalid_dosage_form');
    }

    final imageUrl = item.imageUrl;

    if (imageUrl != null && !_isValidUrl(imageUrl)) {
      throw Exception('medication_invalid_image_url');
    }
  }

  MedicationModel _normalizedMedication(MedicationModel item) {
    return MedicationModel(
      id: item.id.trim(),
      name: item.name.trim(),
      genericName: _emptyToNull(item.genericName),
      category: _emptyToNull(item.category),
      dosageForm: _emptyToNull(item.dosageForm),
      strength: _emptyToNull(item.strength),
      manufacturer: _emptyToNull(item.manufacturer),
      barcode: _emptyToNull(item.barcode),
      requiresPrescription: item.requiresPrescription,
      price: item.price,
      costPrice: item.costPrice,
      description: _emptyToNull(item.description),
      imageUrl: _emptyToNull(item.imageUrl),
      isActive: item.isActive,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  String? _emptyToNull(String? value) {
    final text = value?.trim();

    if (text == null || text.isEmpty) return null;

    return text;
  }

  String _normalizeSearchText(String? value) {
    return value?.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ') ?? '';
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);

    return uri != null && uri.hasScheme && uri.host.isNotEmpty;
  }
}

const _validCategories = [
  'analgesic',
  'antibiotic',
  'antiviral',
  'antifungal',
  'cardiovascular',
  'diabetes',
  'respiratory',
  'gastrointestinal',
  'dermatology',
  'vitamins_supplements',
  'otc',
  'other',
];

const _validForms = [
  'tablet',
  'capsule',
  'syrup',
  'injection',
  'cream',
  'drops',
  'inhaler',
  'patch',
  'suppository',
  'other',
];
