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
      emit(const SuppliersState.failure(message: 'could_not_load_suppliers'));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  Future<bool> createSupplier(SupplierModel supplier) async {
    final oldSuppliers = List<SupplierModel>.from(_allSuppliers);

    if (state is SuppliersLoaded) {
      emit((state as SuppliersLoaded).copyWith(isSubmitting: true));
    }

    try {
      final created = await _suppliersRepo.createSupplier(supplier);

      _allSuppliers = [created, ...oldSuppliers];

      _emitLoaded();

      return true;
    } catch (error) {
      _allSuppliers = oldSuppliers;

      emit(
        SuppliersState.loaded(
          suppliers: _getFilteredSuppliers(),
          searchQuery: _searchQuery,
        ),
      );

      emit(const SuppliersState.failure(message: 'could_not_save_supplier'));

      return false;
    }
  }

  Future<bool> updateSupplier(SupplierModel supplier) async {
    final oldSuppliers = List<SupplierModel>.from(_allSuppliers);

    if (state is SuppliersLoaded) {
      emit((state as SuppliersLoaded).copyWith(isSubmitting: true));
    }

    try {
      final updated = await _suppliersRepo.updateSupplier(supplier);

      _allSuppliers = oldSuppliers.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      _emitLoaded();

      return true;
    } catch (error) {
      _allSuppliers = oldSuppliers;

      emit(
        SuppliersState.loaded(
          suppliers: _getFilteredSuppliers(),
          searchQuery: _searchQuery,
        ),
      );

      emit(const SuppliersState.failure(message: 'could_not_save_supplier'));

      return false;
    }
  }

  List<SupplierModel> _getFilteredSuppliers() {
    final query = _searchQuery.toLowerCase().trim();

    if (query.isEmpty) return _allSuppliers;

    return _allSuppliers.where((supplier) {
      return supplier.name.toLowerCase().contains(query) ||
          (supplier.contactPerson?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _emitLoaded() {
    emit(
      SuppliersState.loaded(
        suppliers: _getFilteredSuppliers(),
        searchQuery: _searchQuery,
      ),
    );
  }
}
