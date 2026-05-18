import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/medication_model.dart';
import '../../data/repos/medications_repo.dart';
import 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  MedicationsCubit({required MedicationsRepo medicationsRepo})
      : _medicationsRepo = medicationsRepo,
        super(const MedicationsState.initial());

  final MedicationsRepo _medicationsRepo;
  List<MedicationModel> _allMedications = [];
  String _searchQuery = '';
  String _selectedCategory = 'all';

  Future<void> getMedications() async {
    emit(const MedicationsState.loading());
    try {
      _allMedications = await _medicationsRepo.getMedications();
      _emitLoaded();
    } catch (error) {
      emit(MedicationsState.failure(message: error.toString()));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitLoaded();
  }

  void updateSelectedCategory(String value) {
    _selectedCategory = value;
    _emitLoaded();
  }

  Future<void> createMedication(MedicationModel medication) async {
    if (state is MedicationsLoaded) emit((state as MedicationsLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _medicationsRepo.createMedication(medication);
      _allMedications = [created, ..._allMedications];
      _emitLoaded();
    } catch (error) {
      emit(MedicationsState.failure(message: error.toString()));
    }
  }

  Future<void> updateMedication(MedicationModel medication) async {
    if (state is MedicationsLoaded) emit((state as MedicationsLoaded).copyWith(isSubmitting: true));
    try {
      final updated = await _medicationsRepo.updateMedication(medication);
      _allMedications = _allMedications.map((item) => item.id == updated.id ? updated : item).toList();
      _emitLoaded();
    } catch (error) {
      emit(MedicationsState.failure(message: error.toString()));
    }
  }

  void _emitLoaded() {
    final query = _searchQuery.toLowerCase();
    final filtered = _allMedications.where((medication) {
      final matchSearch = medication.name.toLowerCase().contains(query) ||
          (medication.genericName?.toLowerCase().contains(query) ?? false);
      final matchCategory = _selectedCategory == 'all' || medication.category == _selectedCategory;
      return matchSearch && matchCategory;
    }).toList();
    emit(MedicationsState.loaded(
      medications: filtered,
      searchQuery: _searchQuery,
      selectedCategory: _selectedCategory,
    ));
  }
}
