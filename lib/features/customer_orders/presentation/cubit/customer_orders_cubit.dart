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
      emit(CustomerOrdersState.loaded(
        orders: _filteredOrders,
        medications: results[1] as dynamic,
        branches: results[2] as dynamic,
        searchQuery: _searchQuery,
        selectedStatus: _selectedStatus,
      ));
    } catch (error) {
      emit(CustomerOrdersState.failure(message: error.toString()));
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

  Future<void> createCustomerOrder(CustomerOrderModel order) async {
    if (state is CustomerOrdersLoaded) emit((state as CustomerOrdersLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _customerOrdersRepo.createCustomerOrder(order);
      _allOrders = [created, ..._allOrders];
      _emitFromLoaded();
    } catch (error) {
      emit(CustomerOrdersState.failure(message: error.toString()));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _customerOrdersRepo.updateCustomerOrderFields(id, {'status': status});
    _allOrders = _allOrders.map((order) {
      if (order.id != id) return order;
      return CustomerOrderModel.fromJson({...order.toJson(), 'status': status});
    }).toList();
    _emitFromLoaded();
  }

  List<CustomerOrderModel> get _filteredOrders {
    final query = _searchQuery.toLowerCase();
    return _allOrders.where((order) {
      final matchSearch = order.customerName.toLowerCase().contains(query) ||
          (order.orderNumber?.toLowerCase().contains(query) ?? false);
      final matchStatus = _selectedStatus == 'all' || order.status == _selectedStatus;
      return matchSearch && matchStatus;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is CustomerOrdersLoaded) {
      emit(current.copyWith(orders: _filteredOrders, searchQuery: _searchQuery, selectedStatus: _selectedStatus, isSubmitting: false));
    }
  }
}
