import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_source/medications_remote_data_source.dart';
import '../models/medication_model.dart';

class MedicationsRepo {
  const MedicationsRepo({required MedicationsRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final MedicationsRemoteDataSource _remoteDataSource;

  Future<(List<MedicationModel>, DocumentSnapshot?)> getMedications({DocumentSnapshot? startAfter}) => _remoteDataSource.getMedications(startAfter: startAfter);

  Future<MedicationModel> createMedication(MedicationModel item) => _remoteDataSource.createMedication(item);

  Future<MedicationModel> updateMedication(MedicationModel item) => _remoteDataSource.updateMedication(item);

  Future<void> updateMedicationFields(String id, Map<String, dynamic> data) =>
      _remoteDataSource.updateMedicationFields(id, data);

  Future<void> deleteMedication(String id) => _remoteDataSource.deleteMedication(id);

  Future<void> deleteAllMedications() => _remoteDataSource.deleteAllMedications();
}
