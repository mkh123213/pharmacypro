import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/sale_model.dart';
import '../../data/repos/sales_repo.dart';
import '../../data/data_source/sales_remote_data_source.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit({required SalesRepo salesRepo})
    : _salesRepo = salesRepo,
      super(const SalesState.initial());

  final SalesRepo _salesRepo;

  List<SaleModel> _allSales = [];
  DocumentSnapshot? _lastSaleDocument;
  bool _hasMoreSales = true;
  String _searchQuery = '';
  String _selectedPaymentMethod = 'all';

  Future<void> getSalesData() async {
    emit(const SalesState.loading());

    try {
      final results = await Future.wait([
        _salesRepo.getSales(),
        _salesRepo.getMedications(),
        _salesRepo.getBranches(),
      ]);

      final (sales, lastDocument) = results[0] as (List<SaleModel>, DocumentSnapshot?);
      _allSales = sales;
      _lastSaleDocument = lastDocument;
      _hasMoreSales = sales.length >= SalesRemoteDataSource.pageSize;

      emit(
        SalesState.loaded(
          sales: _filteredSales,
          medications: results[1] as dynamic,
          branches: results[2] as dynamic,
          searchQuery: _searchQuery,
          selectedPaymentMethod: _selectedPaymentMethod,
          hasMore: _hasMoreSales,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(const SalesState.failure(message: 'could_not_load_sales'));
    }
  }

  Future<void> loadMoreSales() async {
    final current = state;
    if (current is! SalesLoaded || !_hasMoreSales || current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    try {
      final (newSales, lastDocument) = await _salesRepo.getSales(
        startAfter: _lastSaleDocument,
      );

      if (newSales.length < SalesRemoteDataSource.pageSize) {
        _hasMoreSales = false;
      }

      if (newSales.isNotEmpty) {
        _lastSaleDocument = lastDocument;
        _allSales = [..._allSales, ...newSales];
      }

      _emitFromLoaded();
    } catch (error) {
      emit(
        current.copyWith(
          isLoadingMore: false,
          errorMessage: 'could_not_load_more_sales',
        ),
      );
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  void updateSelectedPaymentMethod(String value) {
    _selectedPaymentMethod = value;
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

      emit(
        current.copyWith(
          sales: _filteredSales,
          isSubmitting: false,
          errorMessage: _saleErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> deleteSale(String id) async {
    final current = state;

    if (current is! SalesLoaded) return false;

    final oldSales = List<SaleModel>.from(_allSales);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _salesRepo.deleteSale(id);

      _allSales = oldSales.where((item) => item.id != id).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allSales = oldSales;

      emit(
        current.copyWith(
          sales: _filteredSales,
          isSubmitting: false,
          errorMessage: 'could_not_delete_sale',
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

    if (text.contains('sale_missing_branch')) {
      return 'sale_missing_branch';
    }

    if (text.contains('sale_has_no_items')) {
      return 'sale_has_no_items';
    }

    if (text.contains('sale_invalid_payment_method')) {
      return 'sale_invalid_payment_method';
    }

    if (text.contains('sale_invalid_subtotal')) {
      return 'sale_invalid_subtotal';
    }

    if (text.contains('sale_invalid_discount')) {
      return 'sale_invalid_discount';
    }

    if (text.contains('sale_discount_greater_than_subtotal')) {
      return 'sale_discount_greater_than_subtotal';
    }

    if (text.contains('sale_invalid_total')) {
      return 'sale_invalid_total';
    }

    if (text.contains('sale_item_missing_medication')) {
      return 'sale_item_missing_medication';
    }

    if (text.contains('sale_item_invalid_quantity')) {
      return 'sale_item_invalid_quantity';
    }

    if (text.contains('sale_item_invalid_unit_price')) {
      return 'sale_item_invalid_unit_price';
    }

    if (text.contains('sale_item_invalid_total')) {
      return 'sale_item_invalid_total';
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
      final matchSearch =
          query.isEmpty ||
          (sale.customerName?.toLowerCase().contains(query) ?? false) ||
          (sale.customerPhone?.toLowerCase().contains(query) ?? false) ||
          (sale.branchName?.toLowerCase().contains(query) ?? false) ||
          (sale.saleNumber?.toLowerCase().contains(query) ?? false) ||
          sale.paymentMethod.toLowerCase().contains(query) ||
          sale.status.toLowerCase().contains(query);

      final matchPayment =
          _selectedPaymentMethod == 'all' ||
          sale.paymentMethod == _selectedPaymentMethod;

      return matchSearch && matchPayment;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is SalesLoaded) {
      emit(
        current.copyWith(
          sales: _filteredSales,
          searchQuery: _searchQuery,
          selectedPaymentMethod: _selectedPaymentMethod,
          isSubmitting: false,
          isLoadingMore: false,
          hasMore: _hasMoreSales,
          errorMessage: null,
        ),
      );
    }
  }
}
