import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/purchase_order_model.dart';
import '../../data/repos/purchase_orders_repo.dart';
import 'purchase_orders_state.dart';

class PurchaseOrdersCubit extends Cubit<PurchaseOrdersState> {
  PurchaseOrdersCubit({required PurchaseOrdersRepo purchaseOrdersRepo})
      : _purchaseOrdersRepo = purchaseOrdersRepo,
        super(const PurchaseOrdersState.initial());

  final PurchaseOrdersRepo _purchaseOrdersRepo;
  List<PurchaseOrderModel> _allPurchaseOrders = [];
  String _searchQuery = '';

  Future<void> getPurchaseOrdersData() async {
    emit(const PurchaseOrdersState.loading());
    try {
      final results = await Future.wait([
        _purchaseOrdersRepo.getPurchaseOrders(),
        _purchaseOrdersRepo.getSuppliers(),
        _purchaseOrdersRepo.getBranches(),
        _purchaseOrdersRepo.getMedications(),
      ]);
      _allPurchaseOrders = results[0] as List<PurchaseOrderModel>;
      emit(PurchaseOrdersState.loaded(
        purchaseOrders: _filteredPurchaseOrders,
        suppliers: results[1] as dynamic,
        branches: results[2] as dynamic,
        medications: results[3] as dynamic,
        searchQuery: _searchQuery,
      ));
    } catch (error) {
      emit(PurchaseOrdersState.failure(message: error.toString()));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  Future<void> createPurchaseOrder(PurchaseOrderModel purchaseOrder) async {
    if (state is PurchaseOrdersLoaded) emit((state as PurchaseOrdersLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _purchaseOrdersRepo.createPurchaseOrder(purchaseOrder);
      _allPurchaseOrders = [created, ..._allPurchaseOrders];
      _emitFromLoaded();
    } catch (error) {
      emit(PurchaseOrdersState.failure(message: error.toString()));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _purchaseOrdersRepo.updatePurchaseOrderFields(id, {'status': status});
    _allPurchaseOrders = _allPurchaseOrders.map((order) {
      if (order.id != id) return order;
      return PurchaseOrderModel.fromJson({...order.toJson(), 'status': status});
    }).toList();
    _emitFromLoaded();
  }

  List<PurchaseOrderModel> get _filteredPurchaseOrders {
    final query = _searchQuery.toLowerCase();
    return _allPurchaseOrders.where((order) {
      return (order.orderNumber?.toLowerCase().contains(query) ?? false) ||
          (order.supplierName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is PurchaseOrdersLoaded) {
      emit(current.copyWith(purchaseOrders: _filteredPurchaseOrders, searchQuery: _searchQuery, isSubmitting: false));
    }
  }
}
