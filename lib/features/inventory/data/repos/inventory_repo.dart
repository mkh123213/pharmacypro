import 'package:pharmacypro/features/inventory/data/models/inventory_alert_model.dart';
import 'package:pharmacypro/features/inventory/data/models/stock_movement_model.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/inventory_remote_data_source.dart';
import '../models/inventory_model.dart';

class InventoryRepo {
  const InventoryRepo({required InventoryRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final InventoryRemoteDataSource _remoteDataSource;

  Future<List<InventoryModel>> getInventory() {
    return _remoteDataSource.getInventory();
  }

  Future<List<BranchModel>> getBranches() {
    return _remoteDataSource.getBranches();
  }

  Future<List<MedicationModel>> getMedications() {
    return _remoteDataSource.getMedications();
  }

  Future<InventoryModel> createInventory(InventoryModel item) {
    return _remoteDataSource.createInventory(item);
  }

  Future<InventoryModel> updateInventory(InventoryModel item) {
    return _remoteDataSource.updateInventory(item);
  }

  Future<List<StockMovementModel>> getStockMovements() {
    return _remoteDataSource.getStockMovements();
  }

  Future<InventoryModel> adjustInventoryStock({
    required InventoryModel item,
    required int quantityChange,
    required String reason,
  }) {
    return _remoteDataSource.adjustInventoryStock(
      item: item,
      quantityChange: quantityChange,
      reason: reason,
    );
  }

  Future<List<InventoryAlertModel>> getInventoryAlerts() {
    return _remoteDataSource.getInventoryAlerts();
  }

  Future<InventoryModel> removeExpiredStock({
    required InventoryModel item,
    required String reason,
  }) {
    return _remoteDataSource.removeExpiredStock(item: item, reason: reason);
  }
}
