import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../inventory/data/models/inventory_model.dart';
import '../../../inventory/data/models/stock_movement_model.dart';
import '../../../prescriptions/data/models/prescription_model.dart';
import '../../../sales/data/models/sale_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../models/dashboard_chart_model.dart';
import '../models/dashboard_summary_model.dart';

class DashboardRemoteDataSource {
  DashboardRemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<DashboardSummaryModel> getDashboardSummary() async {
    final result = await Future.wait([
      _firestore
          .collection('sales')
          .orderBy('created_at', descending: true)
          .limit(100)
          .get(),
      _firestore.collection('inventory').get(),
      _firestore
          .collection('prescriptions')
          .orderBy('created_at', descending: true)
          .limit(20)
          .get(),
      _firestore.collection('staff').get(),
      _firestore
          .collection('customer_orders')
          .orderBy('created_at', descending: true)
          .limit(20)
          .get(),
      _firestore
          .collection('stock_movements')
          .orderBy('created_at', descending: true)
          .limit(100)
          .get(),
    ]);

    final sales = (result[0]).docs.map(SaleModel.fromFirestore).toList();

    final inventory = (result[1]).docs
        .map(InventoryModel.fromFirestore)
        .toList();

    final prescriptions = (result[2]).docs
        .map(PrescriptionModel.fromFirestore)
        .toList();

    final staff = (result[3]).docs.map(StaffModel.fromFirestore).toList();

    final orders = (result[4]).docs
        .map(CustomerOrderModel.fromFirestore)
        .toList();

    final stockMovements = (result[5]).docs
        .map(StockMovementModel.fromFirestore)
        .toList();

    final last7Days = List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: 6 - index));

      final key = DateFormat('yyyy-MM-dd').format(date);

      final daySales = sales.where((sale) {
        if (sale.createdAt == null) return false;

        return DateFormat('yyyy-MM-dd').format(sale.createdAt!) == key;
      }).toList();

      return DashboardChartModel(
        label: DateFormat('EEE').format(date),
        revenue: daySales.fold(0, (sum, sale) => sum + sale.totalAmount),
        count: daySales.length,
      );
    });

    return DashboardSummaryModel(
      sales: sales,
      inventory: inventory,
      prescriptions: prescriptions,
      staff: staff,
      orders: orders,
      last7Days: last7Days,
      stockMovements: stockMovements,
    );
  }
}
