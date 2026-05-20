import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/customer_order_model.dart';
import '../../data/repos/customer_orders_repo.dart';
import 'customer_orders_state.dart';

class CustomerOrdersCubit extends Cubit<CustomerOrdersState> {
  CustomerOrdersCubit({required CustomerOrdersRepo customerOrdersRepo})
    : _customerOrdersRepo = customerOrdersRepo,
      super(const CustomerOrdersState.initial());

  final CustomerOrdersRepo _customerOrdersRepo;

  List<CustomerOrderModel> _allOrders = [];
  String _searchQuery = '';
  String _selectedStatus = 'all';
  String _selectedBranchId = 'all';

  Future<void> getCustomerOrdersData() async {
    emit(const CustomerOrdersState.loading());

    try {
      final results = await Future.wait([
        _customerOrdersRepo.getCustomerOrders(),
        _customerOrdersRepo.getMedications(),
        _customerOrdersRepo.getBranches(),
      ]);

      _allOrders = results[0] as List<CustomerOrderModel>;

      emit(
        CustomerOrdersState.loaded(
          orders: _filteredOrders,
          medications: results[1] as dynamic,
          branches: results[2] as dynamic,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        const CustomerOrdersState.failure(
          message: 'could_not_load_customer_orders',
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

  Future<bool> createCustomerOrder(CustomerOrderModel order) async {
    final current = state;

    if (current is! CustomerOrdersLoaded) return false;

    final oldOrders = List<CustomerOrderModel>.from(_allOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _customerOrdersRepo.createCustomerOrder(order);

      _allOrders = [created, ...oldOrders];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allOrders = oldOrders;

      emit(
        current.copyWith(
          orders: _filteredOrders,
          isSubmitting: false,
          errorMessage: _customerOrderErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! CustomerOrdersLoaded) return false;

    final oldOrders = List<CustomerOrderModel>.from(_allOrders);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _customerOrdersRepo.updateCustomerOrderFields(id, {
        'status': status,
      });

      _allOrders = oldOrders.map((order) {
        if (order.id != id) return order;

        return order.copyWith(status: status);
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allOrders = oldOrders;

      emit(
        current.copyWith(
          orders: _filteredOrders,
          isSubmitting: false,
          errorMessage: _customerOrderErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _customerOrderErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    if (text.contains('customer_order_customer_name_required')) {
      return 'customer_order_customer_name_required';
    }

    if (text.contains('customer_order_missing_branch')) {
      return 'customer_order_missing_branch';
    }

    if (text.contains('customer_order_invalid_type')) {
      return 'customer_order_invalid_type';
    }

    if (text.contains('customer_order_invalid_payment_method')) {
      return 'customer_order_invalid_payment_method';
    }

    if (text.contains('customer_order_delivery_address_required')) {
      return 'customer_order_delivery_address_required';
    }

    if (text.contains('customer_order_invalid_total')) {
      return 'customer_order_invalid_total';
    }

    if (text.contains('customer_order_item_missing_medication')) {
      return 'customer_order_item_missing_medication';
    }

    if (text.contains('customer_order_item_invalid_quantity')) {
      return 'customer_order_item_invalid_quantity';
    }

    if (text.contains('customer_order_item_invalid_unit_price')) {
      return 'customer_order_item_invalid_unit_price';
    }

    if (text.contains('customer_order_item_invalid_total')) {
      return 'customer_order_item_invalid_total';
    }

    if (text.contains('customer_order_not_found')) {
      return 'customer_order_not_found';
    }

    if (text.contains('customer_order_already_delivered')) {
      return 'customer_order_already_delivered';
    }

    if (text.contains('customer_order_already_cancelled')) {
      return 'customer_order_already_cancelled';
    }

    if (text.contains('customer_order_has_no_items')) {
      return 'customer_order_has_no_items';
    }

    if (text.contains('invalid_customer_order_status_transition')) {
      return 'invalid_customer_order_status_transition';
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

    return 'could_not_update_order_status';
  }

  List<CustomerOrderModel> get _filteredOrders {
    final query = _searchQuery.toLowerCase().trim();

    return _allOrders.where((order) {
      final matchSearch =
          query.isEmpty ||
          order.customerName.toLowerCase().contains(query) ||
          (order.customerPhone?.toLowerCase().contains(query) ?? false) ||
          (order.customerEmail?.toLowerCase().contains(query) ?? false) ||
          (order.branchName?.toLowerCase().contains(query) ?? false) ||
          (order.orderNumber?.toLowerCase().contains(query) ?? false) ||
          order.orderType.toLowerCase().contains(query) ||
          order.paymentMethod.toLowerCase().contains(query);

      final matchStatus =
          _selectedStatus == 'all' || order.status == _selectedStatus;

      final matchBranch =
          _selectedBranchId == 'all' || order.branchId == _selectedBranchId;

      return matchSearch && matchStatus && matchBranch;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is CustomerOrdersLoaded) {
      emit(
        current.copyWith(
          orders: _filteredOrders,
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
