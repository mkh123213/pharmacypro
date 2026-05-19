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

    if (text.contains('customer_order_not_found')) {
      return 'customer_order_not_found';
    }

    if (text.contains('customer_order_already_delivered')) {
      return 'customer_order_already_delivered';
    }

    if (text.contains('customer_order_has_no_items')) {
      return 'customer_order_has_no_items';
    }

    if (text.contains('not_enough_stock_for_medication:')) {
      final medicationName = text
          .split('not_enough_stock_for_medication:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'not_enough_stock_for_medication|$medicationName';
    }

    return 'could_not_update_order_status';
  }

  List<CustomerOrderModel> get _filteredOrders {
    final query = _searchQuery.toLowerCase().trim();

    return _allOrders.where((order) {
      final matchSearch =
          order.customerName.toLowerCase().contains(query) ||
          (order.customerPhone?.toLowerCase().contains(query) ?? false) ||
          (order.branchName?.toLowerCase().contains(query) ?? false) ||
          (order.orderNumber?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == 'all' || order.status == _selectedStatus;

      return matchSearch && matchStatus;
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
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
