import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../inventory/data/models/inventory_model.dart';
import '../../../prescriptions/data/models/prescription_model.dart';
import '../../../sales/data/models/sale_model.dart';
import '../models/report_chart_model.dart';
import '../models/reports_summary_model.dart';

class ReportsRemoteDataSource {
  ReportsRemoteDataSource({required FirebaseFirestore firestore}) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  Future<({ReportsSummaryModel summary,List<BranchModel> branches})> getReports({String branchId='all'}) async{
    final r=await Future.wait([_firestore.collection('sales').orderBy('created_at',descending:true).limit(500).get(),_firestore.collection('inventory').get(),_firestore.collection('customer_orders').orderBy('created_at',descending:true).limit(200).get(),_firestore.collection('prescriptions').orderBy('created_at',descending:true).limit(200).get(),_firestore.collection('branches').get()]);
    final sales=(r[0] as QuerySnapshot<Map<String,dynamic>>).docs.map(SaleModel.fromFirestore).toList();
    final inventory=(r[1] as QuerySnapshot<Map<String,dynamic>>).docs.map(InventoryModel.fromFirestore).toList();
    final orders=(r[2] as QuerySnapshot<Map<String,dynamic>>).docs.map(CustomerOrderModel.fromFirestore).toList();
    final prescriptions=(r[3] as QuerySnapshot<Map<String,dynamic>>).docs.map(PrescriptionModel.fromFirestore).toList();
    final branches=(r[4] as QuerySnapshot<Map<String,dynamic>>).docs.map(BranchModel.fromFirestore).toList();
    final filteredSales=branchId=='all'?sales:sales.where((s)=>s.branchId==branchId).toList();
    final totalRevenue=filteredSales.fold<double>(0,(sum,s)=>sum+s.totalAmount);
    final totalOrders=branchId=='all'?orders.length:orders.where((o)=>o.branchId==branchId).length;
    final prescriptionsCount=branchId=='all'?prescriptions.length:prescriptions.where((p)=>p.branchId==branchId).length;
    final lowStock=inventory.where((i)=>i.isLowStock).length;
    final dailyRevenue=List.generate(30,(index){final date=DateTime.now().subtract(Duration(days:29-index));final key=DateFormat('yyyy-MM-dd').format(date);final value=filteredSales.where((s)=>s.createdAt!=null&&DateFormat('yyyy-MM-dd').format(s.createdAt!)==key).fold<double>(0,(sum,s)=>sum+s.totalAmount);return ReportChartModel(label:DateFormat('MM/dd').format(date),value:value);});
    final revenueByBranch=branches.map((b)=>ReportChartModel(label:b.name,value:sales.where((s)=>s.branchId==b.id).fold<double>(0,(sum,s)=>sum+s.totalAmount))).where((e)=>e.value>0).toList();
    final paymentMethods=['cash','card','insurance','online'].map((p)=>ReportChartModel(label:p,value:filteredSales.where((s)=>s.paymentMethod==p).length.toDouble())).where((e)=>e.value>0).toList();
    final orderStatusBreakdown=['pending','confirmed','processing','ready','delivered','cancelled'].map((s)=>ReportChartModel(label:s,value:orders.where((o)=>o.status==s).length.toDouble())).where((e)=>e.value>0).toList();
    return (summary:ReportsSummaryModel(totalRevenue:totalRevenue,totalOrders:totalOrders,lowStockItems:lowStock,prescriptionsCount:prescriptionsCount,dailyRevenue:dailyRevenue,revenueByBranch:revenueByBranch,paymentMethods:paymentMethods,orderStatusBreakdown:orderStatusBreakdown),branches:branches);
  }
}
