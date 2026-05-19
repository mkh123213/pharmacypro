import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../data_source/prescriptions_remote_data_source.dart';
import '../models/prescription_model.dart';

class PrescriptionsRepo {
  const PrescriptionsRepo({
    required PrescriptionsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final PrescriptionsRemoteDataSource _remoteDataSource;

  Future<List<PrescriptionModel>> getPrescriptions() {
    return _remoteDataSource.getPrescriptions();
  }

  Future<List<BranchModel>> getBranches() {
    return _remoteDataSource.getBranches();
  }

  Future<List<MedicationModel>> getMedications() {
    return _remoteDataSource.getMedications();
  }

  Future<PrescriptionModel> createPrescription(PrescriptionModel item) {
    return _remoteDataSource.createPrescription(item);
  }

  Future<void> updatePrescriptionFields(String id, Map<String, dynamic> data) {
    return _remoteDataSource.updatePrescriptionFields(id, data);
  }
}
