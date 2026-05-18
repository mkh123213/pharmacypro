import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/sale_model.dart';
import '../../data/repos/sales_repo.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit({required SalesRepo salesRepo})
      : _salesRepo = salesRepo,
        super(const SalesState.initial());

  final SalesRepo _salesRepo;
  List<SaleModel> _allSales = [];
  String _searchQuery = '';

  Future<void> getSalesData() async {
    emit(const SalesState.loading());
    try {
      final results = await Future.wait([
        _salesRepo.getSales(),
        _salesRepo.getMedications(),
        _salesRepo.getBranches(),
      ]);
      _allSales = results[0] as List<SaleModel>;
      emit(SalesState.loaded(
        sales: _filteredSales,
        medications: results[1] as dynamic,
        branches: results[2] as dynamic,
        searchQuery: _searchQuery,
      ));
    } catch (error) {
      emit(SalesState.failure(message: error.toString()));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  Future<void> createSale(SaleModel sale) async {
    if (state is SalesLoaded) emit((state as SalesLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _salesRepo.createSale(sale);
      _allSales = [created, ..._allSales];
      _emitFromLoaded();
    } catch (error) {
      emit(SalesState.failure(message: error.toString()));
    }
  }

  List<SaleModel> get _filteredSales {
    final query = _searchQuery.toLowerCase();
    return _allSales.where((sale) {
      return (sale.customerName?.toLowerCase().contains(query) ?? false) ||
          (sale.saleNumber?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is SalesLoaded) {
      emit(current.copyWith(sales: _filteredSales, searchQuery: _searchQuery, isSubmitting: false));
    }
  }
}
