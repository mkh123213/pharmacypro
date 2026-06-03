import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/supplier_model.dart';
import '../../data/repos/suppliers_repo.dart';
import 'suppliers_state.dart';

class SuppliersCubit extends Cubit<SuppliersState> {
  SuppliersCubit({required SuppliersRepo suppliersRepo})
    : _suppliersRepo = suppliersRepo,
      super(const SuppliersState.initial());

  final SuppliersRepo _suppliersRepo;

  List<SupplierModel> _allSuppliers = [];
  String _searchQuery = '';
  String _selectedStatus = 'all';

  Future<void> getSuppliers() async {
    emit(const SuppliersState.loading());

    try {
      _allSuppliers = await _suppliersRepo.getSuppliers();

      _emitLoaded();
    } catch (error) {
      emit(const SuppliersState.failure(message: 'could_not_load_suppliers'));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  void updateSelectedStatus(String value) {
    _selectedStatus = value;
    _emitLoaded();
  }

  Future<bool> createSupplier(SupplierModel supplier) async {
    final current = state;

    if (current is! SuppliersLoaded) return false;

    final oldSuppliers = List<SupplierModel>.from(_allSuppliers);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _suppliersRepo.createSupplier(
        _normalizedSupplier(supplier),
      );

      _allSuppliers = [created, ...oldSuppliers];

      _emitLoaded();

      return true;
    } catch (error) {
      _allSuppliers = oldSuppliers;

      emit(
        current.copyWith(
          suppliers: _filteredSuppliers,
          isSubmitting: false,
          errorMessage: _supplierErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateSupplier(SupplierModel supplier) async {
    final current = state;

    if (current is! SuppliersLoaded) return false;

    final oldSuppliers = List<SupplierModel>.from(_allSuppliers);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _suppliersRepo.updateSupplier(
        _normalizedSupplier(supplier),
      );

      _allSuppliers = oldSuppliers.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      _emitLoaded();

      return true;
    } catch (error) {
      _allSuppliers = oldSuppliers;

      emit(
        current.copyWith(
          suppliers: _filteredSuppliers,
          isSubmitting: false,
          errorMessage: _supplierErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> deleteSupplier(String id) async {
    final current = state;

    if (current is! SuppliersLoaded) return false;

    final oldSuppliers = List<SupplierModel>.from(_allSuppliers);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _suppliersRepo.deleteSupplier(id);

      _allSuppliers = oldSuppliers.where((item) => item.id != id).toList();

      _emitLoaded();

      return true;
    } catch (error) {
      _allSuppliers = oldSuppliers;

      emit(
        current.copyWith(
          suppliers: _filteredSuppliers,
          isSubmitting: false,
          errorMessage: 'could_not_delete_supplier',
        ),
      );

      return false;
    }
  }

  SupplierModel _normalizedSupplier(SupplierModel supplier) {
    return SupplierModel(
      id: supplier.id,
      name: supplier.name.trim(),
      contactPerson: supplier.contactPerson?.trim(),
      phone: supplier.phone?.trim(),
      email: supplier.email?.trim().toLowerCase(),
      address: supplier.address?.trim(),
      paymentTerms: supplier.paymentTerms?.trim(),
      isActive: supplier.isActive,
      notes: supplier.notes?.trim(),
      createdAt: supplier.createdAt,
      updatedAt: supplier.updatedAt,
    );
  }

  String _supplierErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('supplier_not_found')) {
      return 'supplier_not_found';
    }

    if (text.contains('supplier_name_required')) {
      return 'supplier_name_required';
    }

    if (text.contains('supplier_invalid_phone')) {
      return 'supplier_invalid_phone';
    }

    if (text.contains('supplier_invalid_email')) {
      return 'supplier_invalid_email';
    }

    if (text.contains('supplier_name_already_exists')) {
      return 'supplier_name_already_exists';
    }

    if (text.contains('supplier_email_already_exists')) {
      return 'supplier_email_already_exists';
    }

    return 'could_not_save_supplier';
  }

  List<SupplierModel> get _filteredSuppliers {
    final query = _searchQuery.toLowerCase().trim();

    return _allSuppliers.where((supplier) {
      final matchSearch =
          query.isEmpty ||
          supplier.name.toLowerCase().contains(query) ||
          (supplier.contactPerson?.toLowerCase().contains(query) ?? false) ||
          (supplier.phone?.toLowerCase().contains(query) ?? false) ||
          (supplier.email?.toLowerCase().contains(query) ?? false) ||
          (supplier.address?.toLowerCase().contains(query) ?? false) ||
          (supplier.paymentTerms?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == 'all' ||
          (_selectedStatus == 'active' && supplier.isActive) ||
          (_selectedStatus == 'inactive' && !supplier.isActive);

      return matchSearch && matchStatus;
    }).toList();
  }

  void _emitLoaded() {
    emit(
      SuppliersState.loaded(
        suppliers: _filteredSuppliers,
        searchQuery: _searchQuery,
        selectedStatus: _selectedStatus,
        errorMessage: null,
      ),
    );
  }
}
