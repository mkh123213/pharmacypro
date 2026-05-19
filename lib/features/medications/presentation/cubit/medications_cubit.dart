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
      emit(
        const MedicationsState.failure(message: 'could_not_load_medications'),
      );
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

  Future<bool> createMedication(MedicationModel medication) async {
    final current = state;

    if (current is! MedicationsLoaded) return false;

    final oldMedications = List<MedicationModel>.from(_allMedications);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _medicationsRepo.createMedication(medication);

      _allMedications = [created, ...oldMedications];

      _emitLoaded();

      return true;
    } catch (error) {
      _allMedications = oldMedications;

      emit(
        current.copyWith(
          medications: _filteredMedications,
          isSubmitting: false,
          errorMessage: _medicationErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateMedication(MedicationModel medication) async {
    final current = state;

    if (current is! MedicationsLoaded) return false;

    final oldMedications = List<MedicationModel>.from(_allMedications);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _medicationsRepo.updateMedication(medication);

      _allMedications = oldMedications.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      _emitLoaded();

      return true;
    } catch (error) {
      _allMedications = oldMedications;

      emit(
        current.copyWith(
          medications: _filteredMedications,
          isSubmitting: false,
          errorMessage: _medicationErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _medicationErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('duplicate_medication_name')) {
      return 'duplicate_medication_name';
    }

    if (text.contains('duplicate_medication_barcode')) {
      return 'duplicate_medication_barcode';
    }

    return 'could_not_save_medication';
  }

  List<MedicationModel> get _filteredMedications {
    final query = _searchQuery.toLowerCase().trim();

    return _allMedications.where((medication) {
      final matchSearch =
          medication.name.toLowerCase().contains(query) ||
          (medication.genericName?.toLowerCase().contains(query) ?? false) ||
          (medication.barcode?.toLowerCase().contains(query) ?? false);

      final matchCategory =
          _selectedCategory == allMedicationCategoriesValue ||
          medication.category == _selectedCategory;

      return matchSearch && matchCategory;
    }).toList();
  }

  void _emitLoaded() {
    emit(
      MedicationsState.loaded(
        medications: _filteredMedications,
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
        errorMessage: null,
      ),
    );
  }
}

const String allMedicationCategoriesValue = 'all';
