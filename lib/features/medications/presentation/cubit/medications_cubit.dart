import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/medication_model.dart';
import '../../data/repos/medications_repo.dart';
import '../../data/data_source/medications_remote_data_source.dart'; // Needed for pageSize
import '../refactor/medication_error_mapper.dart';
import '../refactor/medication_filter_values.dart';
import 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  MedicationsCubit({required MedicationsRepo medicationsRepo})
    : _medicationsRepo = medicationsRepo,
      super(const MedicationsState.initial());

  final MedicationsRepo _medicationsRepo;

  List<MedicationModel> _allMedications = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  String _searchQuery = '';
  String _selectedCategory = allMedicationCategoriesValue;
  String _selectedStatus = allMedicationStatusesValue;

  Future<void> getMedications({bool loadMore = false}) async {
    if (loadMore) {
      if (!_hasMore || (state is MedicationsLoaded && (state as MedicationsLoaded).isLoadingMore)) {
        return;
      }
      
      final current = state as MedicationsLoaded;
      emit(current.copyWith(isLoadingMore: true));
    } else {
      _allMedications = [];
      _lastDocument = null;
      _hasMore = true;
      emit(const MedicationsState.loading());
    }

    try {
      final (newMedications, lastDocument) = await _medicationsRepo.getMedications(
        startAfter: _lastDocument,
      );

      if (newMedications.length < MedicationsRemoteDataSource.pageSize) {
        _hasMore = false;
      }

      if (newMedications.isNotEmpty) {
        _lastDocument = lastDocument;
        _allMedications = [..._allMedications, ...newMedications];
      }

      _emitLoaded();
    } catch (error) {
      final current = state;
      if (current is MedicationsLoaded) {
        emit(
          current.copyWith(
            medications: _filteredMedications,
            isLoadingMore: false,
            errorMessage: MedicationErrorKeys.couldNotLoad,
          ),
        );
        return;
      }

      emit(
        const MedicationsState.failure(message: MedicationErrorKeys.couldNotLoad),
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

  void updateSelectedStatus(String value) {
    _selectedStatus = value;
    _emitLoaded();
  }

  Future<bool> createMedication(MedicationModel medication) async {
    final current = state;

    if (current is! MedicationsLoaded || current.isSubmitting) return false;

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
          errorMessage: medicationExceptionToErrorKey(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateMedication(MedicationModel medication) async {
    final current = state;

    if (current is! MedicationsLoaded || current.isSubmitting) return false;

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
          errorMessage: medicationExceptionToErrorKey(error),
        ),
      );

      return false;
    }
  }

  List<MedicationModel> get _filteredMedications {
    final query = _searchQuery.toLowerCase().trim();

    return _allMedications.where((medication) {
      final matchSearch =
          query.isEmpty ||
          medication.name.toLowerCase().contains(query) ||
          (medication.genericName?.toLowerCase().contains(query) ?? false) ||
          (medication.barcode?.toLowerCase().contains(query) ?? false) ||
          (medication.manufacturer?.toLowerCase().contains(query) ?? false) ||
          (medication.strength?.toLowerCase().contains(query) ?? false);

      final matchCategory =
          _selectedCategory == allMedicationCategoriesValue ||
          medication.category == _selectedCategory;

      final matchStatus =
          _selectedStatus == allMedicationStatusesValue ||
          (_selectedStatus == activeMedicationStatusValue &&
              medication.isActive) ||
          (_selectedStatus == inactiveMedicationStatusValue &&
              !medication.isActive);

      return matchSearch && matchCategory && matchStatus;
    }).toList();
  }

  Future<bool> deleteMedication(String id) async {
    final current = state;

    if (current is! MedicationsLoaded || current.isSubmitting) return false;

    final oldMedications = List<MedicationModel>.from(_allMedications);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _medicationsRepo.deleteMedication(id);

      _allMedications = oldMedications.where((item) => item.id != id).toList();

      _emitLoaded();

      return true;
    } catch (error) {
      _allMedications = oldMedications;

      emit(
        current.copyWith(
          medications: _filteredMedications,
          isSubmitting: false,
          errorMessage: 'could_not_delete_medication',
        ),
      );

      return false;
    }
  }

  Future<bool> deleteAllMedications() async {
    final current = state;

    if (current is! MedicationsLoaded || current.isSubmitting) return false;

    final oldMedications = List<MedicationModel>.from(_allMedications);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _medicationsRepo.deleteAllMedications();

      _allMedications = [];

      _emitLoaded();

      return true;
    } catch (error) {
      _allMedications = oldMedications;

      emit(
        current.copyWith(
          medications: _filteredMedications,
          isSubmitting: false,
          errorMessage: 'could_not_delete_all_medications',
        ),
      );

      return false;
    }
  }

  void _emitLoaded() {
    emit(
      MedicationsState.loaded(
        medications: _filteredMedications,
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
        selectedStatus: _selectedStatus,
        isLoadingMore: false,
        hasMore: _hasMore,
        errorMessage: null,
      ),
    );
  }
}
