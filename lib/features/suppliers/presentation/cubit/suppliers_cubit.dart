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

  Future<void> getSuppliers() async {
    emit(const SuppliersState.loading());
    try {
      _allSuppliers = await _suppliersRepo.getSuppliers();
      _emitLoaded();
    } catch (error) {
      emit(SuppliersState.failure(message: error.toString()));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  Future<void> createSupplier(SupplierModel supplier) async {
    if (state is SuppliersLoaded) emit((state as SuppliersLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _suppliersRepo.createSupplier(supplier);
      _allSuppliers = [created, ..._allSuppliers];
      _emitLoaded();
    } catch (error) {
      emit(SuppliersState.failure(message: error.toString()));
    }
  }

  Future<void> updateSupplier(SupplierModel supplier) async {
    if (state is SuppliersLoaded) emit((state as SuppliersLoaded).copyWith(isSubmitting: true));
    try {
      final updated = await _suppliersRepo.updateSupplier(supplier);
      _allSuppliers = _allSuppliers.map((item) => item.id == updated.id ? updated : item).toList();
      _emitLoaded();
    } catch (error) {
      emit(SuppliersState.failure(message: error.toString()));
    }
  }

  void _emitLoaded() {
    final query = _searchQuery.toLowerCase();
    final filtered = _allSuppliers.where((supplier) {
      return supplier.name.toLowerCase().contains(query) ||
          (supplier.contactPerson?.toLowerCase().contains(query) ?? false);
    }).toList();
    emit(SuppliersState.loaded(suppliers: filtered, searchQuery: _searchQuery));
  }
}
