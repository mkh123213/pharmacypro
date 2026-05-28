import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/supplier_model.dart';

class SuppliersRemoteDataSource {
  SuppliersRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('suppliers');
  }

  Future<List<SupplierModel>> getSuppliers() async {
    final snapshot = await _collection
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map(SupplierModel.fromFirestore).toList();
  }

  Future<SupplierModel> createSupplier(SupplierModel supplier) async {
    final sanitized = _sanitizeSupplier(supplier);

    await _validateSupplier(sanitized);
    await _validateUniqueSupplierName(name: sanitized.name);

    if ((sanitized.email ?? '').trim().isNotEmpty) {
      await _validateUniqueSupplierEmail(email: sanitized.email!);
    }

    final document = await _collection.add({
      ...sanitized.toFirestoreJson(),
      'name_normalized': sanitized.name.trim().toLowerCase(),
      'email_normalized': sanitized.email?.trim().toLowerCase(),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return SupplierModel.fromFirestore(await document.get());
  }

  Future<SupplierModel> updateSupplier(SupplierModel supplier) async {
    final reference = _collection.doc(supplier.id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('supplier_not_found');
    }

    final sanitized = _sanitizeSupplier(supplier);

    await _validateSupplier(sanitized);
    await _validateUniqueSupplierName(
      name: sanitized.name,
      excludingId: sanitized.id,
    );

    if ((sanitized.email ?? '').trim().isNotEmpty) {
      await _validateUniqueSupplierEmail(
        email: sanitized.email!,
        excludingId: sanitized.id,
      );
    }

    await reference.update({
      ...sanitized.toFirestoreJson(),
      'name_normalized': sanitized.name.trim().toLowerCase(),
      'email_normalized': sanitized.email?.trim().toLowerCase(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return SupplierModel.fromFirestore(await reference.get());
  }

  Future<void> deleteSupplier(String id) async {
    final reference = _collection.doc(id);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      throw Exception('supplier_not_found');
    }

    await reference.delete();
  }

  SupplierModel _sanitizeSupplier(SupplierModel supplier) {
    return SupplierModel(
      id: supplier.id,
      name: supplier.name.trim(),
      contactPerson: _emptyToNull(supplier.contactPerson),
      phone: _emptyToNull(supplier.phone),
      email: _emptyToNull(supplier.email)?.toLowerCase(),
      address: _emptyToNull(supplier.address),
      paymentTerms: _emptyToNull(supplier.paymentTerms),
      isActive: supplier.isActive,
      notes: _emptyToNull(supplier.notes),
      createdAt: supplier.createdAt,
      updatedAt: supplier.updatedAt,
    );
  }

  Future<void> _validateSupplier(SupplierModel supplier) async {
    if (supplier.name.trim().isEmpty) {
      throw Exception('supplier_name_required');
    }

    final phone = supplier.phone?.trim();

    if (phone != null && phone.isNotEmpty && phone.length < 7) {
      throw Exception('supplier_invalid_phone');
    }

    final email = supplier.email?.trim();

    if (email != null && email.isNotEmpty && !_isValidEmail(email)) {
      throw Exception('supplier_invalid_email');
    }
  }

  Future<void> _validateUniqueSupplierName({
    required String name,
    String? excludingId,
  }) async {
    final normalizedName = name.trim().toLowerCase();

    final snapshot = await _collection
        .where('name_normalized', isEqualTo: normalizedName)
        .get();

    for (final document in snapshot.docs) {
      if (excludingId != null && document.id == excludingId) continue;

      throw Exception('supplier_name_already_exists');
    }
  }

  Future<void> _validateUniqueSupplierEmail({
    required String email,
    String? excludingId,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final snapshot = await _collection
        .where('email_normalized', isEqualTo: normalizedEmail)
        .get();

    for (final document in snapshot.docs) {
      if (excludingId != null && document.id == excludingId) continue;

      throw Exception('supplier_email_already_exists');
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
