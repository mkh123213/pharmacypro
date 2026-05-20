import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/branch_model.dart';

class BranchesRemoteDataSource {
  BranchesRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('branches');
  }

  Future<List<BranchModel>> getBranches() async {
    final snapshot = await _collection
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(BranchModel.fromFirestore).toList();
  }

  Future<BranchModel> createBranch(BranchModel item) async {
    final sanitized = _sanitizeBranch(item);

    await _validateBranch(sanitized);
    await _validateUniqueBranchName(name: sanitized.name);

    final document = await _collection.add({
      ...sanitized.toFirestoreJson(),
      'name_normalized': sanitized.name.trim().toLowerCase(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    final snapshot = await document.get();

    return BranchModel.fromFirestore(snapshot);
  }

  Future<BranchModel> updateBranch(BranchModel item) async {
    final reference = _collection.doc(item.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('branch_not_found');
    }

    final sanitized = _sanitizeBranch(item);

    await _validateBranch(sanitized);
    await _validateUniqueBranchName(
      name: sanitized.name,
      excludingId: sanitized.id,
    );

    await reference.update({
      ...sanitized.toFirestoreJson(),
      'name_normalized': sanitized.name.trim().toLowerCase(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    final updatedSnapshot = await reference.get();

    return BranchModel.fromFirestore(updatedSnapshot);
  }

  Future<void> updateBranchFields(String id, Map<String, dynamic> data) async {
    final snapshot = await _collection.doc(id).get();

    if (!snapshot.exists) {
      throw Exception('branch_not_found');
    }

    await _collection.doc(id).update({
      ...data,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  BranchModel _sanitizeBranch(BranchModel item) {
    return item.copyWith(
      name: item.name.trim(),
      address: item.address.trim(),
      city: _emptyToNull(item.city),
      phone: _emptyToNull(item.phone),
      email: _emptyToNull(item.email)?.toLowerCase(),
      managerName: _emptyToNull(item.managerName),
      openingHours: _emptyToNull(item.openingHours),
    );
  }

  Future<void> _validateBranch(BranchModel item) async {
    if (item.name.trim().isEmpty) {
      throw Exception('branch_name_required');
    }

    if (item.address.trim().isEmpty) {
      throw Exception('branch_address_required');
    }

    final phone = item.phone?.trim();

    if (phone != null && phone.isNotEmpty && phone.length < 7) {
      throw Exception('branch_invalid_phone');
    }

    final email = item.email?.trim();

    if (email != null && email.isNotEmpty && !_isValidEmail(email)) {
      throw Exception('branch_invalid_email');
    }
  }

  Future<void> _validateUniqueBranchName({
    required String name,
    String? excludingId,
  }) async {
    final normalizedName = name.trim().toLowerCase();

    final snapshot = await _collection
        .where('name_normalized', isEqualTo: normalizedName)
        .get();

    for (final document in snapshot.docs) {
      if (excludingId != null && document.id == excludingId) continue;

      throw Exception('branch_name_already_exists');
    }
  }

  String? _emptyToNull(String? value) {
    final text = value?.trim();

    if (text == null || text.isEmpty) return null;

    return text;
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }
}
