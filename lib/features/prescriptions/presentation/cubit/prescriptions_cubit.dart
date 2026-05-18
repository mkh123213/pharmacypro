import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prescription_model.dart';
import '../../data/repos/prescriptions_repo.dart';
import 'prescriptions_state.dart';

class PrescriptionsCubit extends Cubit<PrescriptionsState> {
  PrescriptionsCubit({required PrescriptionsRepo prescriptionsRepo})
      : _prescriptionsRepo = prescriptionsRepo,
        super(const PrescriptionsState.initial());

  final PrescriptionsRepo _prescriptionsRepo;
  List<PrescriptionModel> _allPrescriptions = [];
  String _searchQuery = '';
  String _selectedStatus = 'all';

  Future<void> getPrescriptionsData() async {
    emit(const PrescriptionsState.loading());
    try {
      final results = await Future.wait([
        _prescriptionsRepo.getPrescriptions(),
        _prescriptionsRepo.getBranches(),
      ]);
      _allPrescriptions = results[0] as List<PrescriptionModel>;
      emit(PrescriptionsState.loaded(
        prescriptions: _filteredPrescriptions,
        branches: results[1] as dynamic,
        searchQuery: _searchQuery,
        selectedStatus: _selectedStatus,
      ));
    } catch (error) {
      emit(PrescriptionsState.failure(message: error.toString()));
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

  Future<void> createPrescription(PrescriptionModel prescription) async {
    if (state is PrescriptionsLoaded) emit((state as PrescriptionsLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _prescriptionsRepo.createPrescription(prescription);
      _allPrescriptions = [created, ..._allPrescriptions];
      _emitFromLoaded();
    } catch (error) {
      emit(PrescriptionsState.failure(message: error.toString()));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _prescriptionsRepo.updatePrescriptionFields(id, {'status': status});
    _allPrescriptions = _allPrescriptions.map((item) {
      if (item.id != id) return item;
      return PrescriptionModel.fromJson({...item.toJson(), 'status': status});
    }).toList();
    _emitFromLoaded();
  }

  List<PrescriptionModel> get _filteredPrescriptions {
    final query = _searchQuery.toLowerCase();
    return _allPrescriptions.where((p) {
      final matchSearch = p.patientName.toLowerCase().contains(query) ||
          (p.prescriptionNumber?.toLowerCase().contains(query) ?? false) ||
          (p.doctorName?.toLowerCase().contains(query) ?? false);
      final matchStatus = _selectedStatus == 'all' || p.status == _selectedStatus;
      return matchSearch && matchStatus;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is PrescriptionsLoaded) {
      emit(current.copyWith(prescriptions: _filteredPrescriptions, searchQuery: _searchQuery, selectedStatus: _selectedStatus, isSubmitting: false));
    }
  }
}
