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
  String _selectedStatus = 'all';
  String _selectedBranchId = 'all';

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
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
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

  void updateSelectedStatus(String value) {
    _selectedStatus = value;
    _emitFromLoaded();
  }

  void updateSelectedBranch(String value) {
    _selectedBranchId = value;
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

  Future<bool> updatePurchaseOrder(PurchaseOrderModel purchaseOrder) async {
    final current = state;

    if (current is! PurchaseOrdersLoaded) return false;

    final oldPurchaseOrders = List<PurchaseOrderModel>.from(_allPurchaseOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _purchaseOrdersRepo.updatePurchaseOrder(
        purchaseOrder,
      );

      _allPurchaseOrders = oldPurchaseOrders.map((order) {
        return order.id == updated.id ? updated : order;
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

        return order.copyWith(
          status: status,
          receivedAt: status == 'received' ? DateTime.now() : order.receivedAt,
        );
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

    if (text.contains('supplier_not_found')) {
      return 'supplier_not_found';
    }

    if (text.contains('inactive_supplier')) {
      return 'inactive_supplier';
    }

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

    if (text.contains('purchase_order_not_found')) {
      return 'purchase_order_not_found';
    }

    if (text.contains('purchase_order_already_received')) {
      return 'purchase_order_already_received';
    }

    if (text.contains('purchase_order_already_cancelled')) {
      return 'purchase_order_already_cancelled';
    }

    if (text.contains('cannot_cancel_received_purchase_order')) {
      return 'cannot_cancel_received_purchase_order';
    }

    if (text.contains('invalid_purchase_order_status_transition')) {
      return 'invalid_purchase_order_status_transition';
    }

    if (text.contains('only_draft_purchase_orders_can_be_edited')) {
      return 'only_draft_purchase_orders_can_be_edited';
    }

    if (text.contains('purchase_order_has_no_items')) {
      return 'purchase_order_has_no_items';
    }

    if (text.contains('purchase_order_item_missing_medication')) {
      return 'purchase_order_item_missing_medication';
    }

    if (text.contains('purchase_order_item_invalid_quantity')) {
      return 'purchase_order_item_invalid_quantity';
    }

    if (text.contains('purchase_order_item_invalid_unit_cost')) {
      return 'purchase_order_item_invalid_unit_cost';
    }

    if (text.contains('purchase_order_item_invalid_total')) {
      return 'purchase_order_item_invalid_total';
    }

    if (text.contains('purchase_order_invalid_total')) {
      return 'purchase_order_invalid_total';
    }

    return 'could_not_update_purchase_order_status';
  }

  Future<bool> deletePurchaseOrder(String id) async {
    final current = state;

    if (current is! PurchaseOrdersLoaded || current.isSubmitting) return false;

    final oldOrders = List<PurchaseOrderModel>.from(_allPurchaseOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _purchaseOrdersRepo.deletePurchaseOrder(id);

      _allPurchaseOrders = oldOrders.where((item) => item.id != id).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPurchaseOrders = oldOrders;

      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          isSubmitting: false,
          errorMessage: 'could_not_delete_purchase_order',
        ),
      );

      return false;
    }
  }

  List<PurchaseOrderModel> get _filteredPurchaseOrders {
    final query = _searchQuery.toLowerCase().trim();

    return _allPurchaseOrders.where((order) {
      final matchSearch =
          query.isEmpty ||
          (order.orderNumber?.toLowerCase().contains(query) ?? false) ||
          (order.supplierName?.toLowerCase().contains(query) ?? false) ||
          (order.branchName?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == 'all' || order.status == _selectedStatus;

      final matchBranch =
          _selectedBranchId == 'all' || order.branchId == _selectedBranchId;

      return matchSearch && matchStatus && matchBranch;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is PurchaseOrdersLoaded) {
      emit(
        current.copyWith(
          purchaseOrders: _filteredPurchaseOrders,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
