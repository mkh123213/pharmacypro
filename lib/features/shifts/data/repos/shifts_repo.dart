import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../data_source/shifts_remote_data_source.dart';
import '../models/shift_model.dart';

class ShiftsRepo {
  const ShiftsRepo({required ShiftsRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final ShiftsRemoteDataSource _remoteDataSource;

  Future<List<ShiftModel>> getShifts() => _remoteDataSource.getShifts();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<List<StaffModel>> getStaff() => _remoteDataSource.getStaff();
  Future<ShiftModel> createShift(ShiftModel item) => _remoteDataSource.createShift(item);
  Future<void> updateShiftFields(String id, Map<String, dynamic> data) => _remoteDataSource.updateShiftFields(id, data);
}
