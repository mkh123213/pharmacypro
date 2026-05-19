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

      emit(
        SalesState.loaded(
          sales: _filteredSales,
          medications: results[1] as dynamic,
          branches: results[2] as dynamic,
          searchQuery: _searchQuery,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(const SalesState.failure(message: 'could_not_load_sales'));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  Future<bool> createSale(SaleModel sale) async {
    final current = state;

    if (current is! SalesLoaded) return false;

    final oldSales = List<SaleModel>.from(_allSales);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _salesRepo.createSale(sale);

      _allSales = [created, ...oldSales];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allSales = oldSales;

      final message = _saleErrorMessage(error);

      emit(
        current.copyWith(
          sales: _filteredSales,
          isSubmitting: false,
          errorMessage: message,
        ),
      );

      return false;
    }
  }

  String _saleErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    if (text.contains('medication_not_found:')) {
      final medicationName = text
          .split('medication_not_found:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'medication_not_found|$medicationName';
    }

    if (text.contains('inactive_medication:')) {
      final medicationName = text
          .split('inactive_medication:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'inactive_medication|$medicationName';
    }

    if (text.contains('not_enough_stock_for_medication:')) {
      final medicationName = text
          .split('not_enough_stock_for_medication:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'not_enough_stock_for_medication|$medicationName';
    }

    if (text.contains('expired_stock_for_medication:')) {
      final medicationName = text
          .split('expired_stock_for_medication:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'expired_stock_for_medication|$medicationName';
    }

    return 'could_not_complete_sale';
  }

  List<SaleModel> get _filteredSales {
    final query = _searchQuery.toLowerCase().trim();

    return _allSales.where((sale) {
      return (sale.customerName?.toLowerCase().contains(query) ?? false) ||
          (sale.customerPhone?.toLowerCase().contains(query) ?? false) ||
          (sale.branchName?.toLowerCase().contains(query) ?? false) ||
          (sale.saleNumber?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is SalesLoaded) {
      emit(
        current.copyWith(
          sales: _filteredSales,
          searchQuery: _searchQuery,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
