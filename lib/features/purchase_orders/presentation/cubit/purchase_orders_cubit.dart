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

    emit(current.copyWith(isSubmitting: true));

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
        ),
      );

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! PurchaseOrdersLoaded) return false;

    final oldPurchaseOrders = List<PurchaseOrderModel>.from(_allPurchaseOrders);

    emit(current.copyWith(isSubmitting: true));

    try {
      await _purchaseOrdersRepo.updatePurchaseOrderFields(id, {
        'status': status,
      });

      _allPurchaseOrders = oldPurchaseOrders.map((order) {
        if (order.id != id) return order;

        return PurchaseOrderModel.fromJson({
          ...order.toJson(),
          'status': status,
        });
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPurchaseOrders = oldPurchaseOrders;

      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          isSubmitting: false,
        ),
      );

      return false;
    }
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
        ),
      );
    }
  }
}
