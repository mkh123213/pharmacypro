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

      emit(
        PurchaseOrdersState.loaded(
          purchaseOrders: _filteredPurchaseOrders,
          suppliers: results[1] as dynamic,
          branches: results[2] as dynamic,
          medications: results[3] as dynamic,
          searchQuery: _searchQuery,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        const PurchaseOrdersState.failure(
          message: 'could_not_load_purchase_orders',
        ),
      );
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  Future<bool> createPurchaseOrder(PurchaseOrderModel purchaseOrder) async {
    final current = state;

    if (current is! PurchaseOrdersLoaded) return false;

    final oldPurchaseOrders = List<PurchaseOrderModel>.from(_allPurchaseOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _purchaseOrdersRepo.createPurchaseOrder(
        purchaseOrder,
      );

      _allPurchaseOrders = [created, ...oldPurchaseOrders];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPurchaseOrders = oldPurchaseOrders;

      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          isSubmitting: false,
          errorMessage: _purchaseOrderErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! PurchaseOrdersLoaded) return false;

    final oldPurchaseOrders = List<PurchaseOrderModel>.from(_allPurchaseOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _purchaseOrdersRepo.updatePurchaseOrderFields(id, {
        'status': status,
      });

      _allPurchaseOrders = oldPurchaseOrders.map((order) {
        if (order.id != id) return order;

        return order.copyWith(status: status);
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPurchaseOrders = oldPurchaseOrders;

      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          isSubmitting: false,
          errorMessage: _purchaseOrderErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _purchaseOrderErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('purchase_order_not_found')) {
      return 'purchase_order_not_found';
    }

    if (text.contains('purchase_order_already_received')) {
      return 'purchase_order_already_received';
    }

    if (text.contains('purchase_order_has_no_items')) {
      return 'purchase_order_has_no_items';
    }

    return 'could_not_update_purchase_order_status';
  }

  List<PurchaseOrderModel> get _filteredPurchaseOrders {
    final query = _searchQuery.toLowerCase().trim();

    return _allPurchaseOrders.where((order) {
      return (order.orderNumber?.toLowerCase().contains(query) ?? false) ||
          (order.supplierName?.toLowerCase().contains(query) ?? false) ||
          (order.branchName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is PurchaseOrdersLoaded) {
      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          searchQuery: _searchQuery,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
