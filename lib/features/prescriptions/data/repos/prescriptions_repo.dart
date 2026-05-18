import '../../../branches/data/models/branch_model.dart';
import '../data_source/prescriptions_remote_data_source.dart';
import '../models/prescription_model.dart';

class PrescriptionsRepo {
  const PrescriptionsRepo({required PrescriptionsRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final PrescriptionsRemoteDataSource _remoteDataSource;

  Future<List<PrescriptionModel>> getPrescriptions() => _remoteDataSource.getPrescriptions();
  Future<List<BranchModel>> getBranches() => _remoteDataSource.getBranches();
  Future<PrescriptionModel> createPrescription(PrescriptionModel item) => _remoteDataSource.createPrescription(item);
  Future<void> updatePrescriptionFields(String id, Map<String, dynamic> data) => _remoteDataSource.updatePrescriptionFields(id, data);
}
