import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prescription_model.dart';
import '../../data/repos/prescriptions_repo.dart';
import '../../data/data_source/prescriptions_remote_data_source.dart';
import '../refactor/prescriptions_constants.dart';
import 'prescriptions_state.dart';

class PrescriptionsCubit extends Cubit<PrescriptionsState> {
  PrescriptionsCubit({required PrescriptionsRepo prescriptionsRepo})
    : _prescriptionsRepo = prescriptionsRepo,
      super(const PrescriptionsState.initial());

  final PrescriptionsRepo _prescriptionsRepo;

  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  List<PrescriptionModel> _allPrescriptions = [];
  String _searchQuery = '';
  String _selectedStatus = allPrescriptionStatusesValue;
  String _selectedBranchId = allPrescriptionBranchesValue;

  Future<void> getPrescriptionsData({bool loadMore = false}) async {
    if (loadMore) {
      if (!_hasMore || state is! PrescriptionsLoaded) return;
      
      final current = state as PrescriptionsLoaded;
      emit(current.copyWith(isLoadingMore: true));
    } else {
      _allPrescriptions = [];
      _lastDocument = null;
      _hasMore = true;
      emit(const PrescriptionsState.loading());
    }

    try {
      if (loadMore) {
        final (newPrescriptions, lastDocument) = await _prescriptionsRepo.getPrescriptions(
            startAfter: _lastDocument,
        );
        
        if (newPrescriptions.length < PrescriptionsRemoteDataSource.pageSize) {
            _hasMore = false;
        }

        if (newPrescriptions.isNotEmpty) {
            _lastDocument = lastDocument;
            _allPrescriptions = [..._allPrescriptions, ...newPrescriptions];
        }

        _emitFromLoaded();
      } else {
        final results = await Future.wait([
          _prescriptionsRepo.getPrescriptions(),
          _prescriptionsRepo.getBranches(),
          _prescriptionsRepo.getMedications(),
        ]);

        final prescriptionsResult = results[0] as (List<PrescriptionModel>, DocumentSnapshot?);
        _allPrescriptions = prescriptionsResult.$1;
        _lastDocument = prescriptionsResult.$2;
        _hasMore = _allPrescriptions.length >= PrescriptionsRemoteDataSource.pageSize;

        emit(
          PrescriptionsState.loaded(
            prescriptions: _filteredPrescriptions,
            branches: results[1] as dynamic,
            medications: results[2] as dynamic,
            searchQuery: _searchQuery,
            selectedStatus: _selectedStatus,
            selectedBranchId: _selectedBranchId,
            errorMessage: null,
            hasMore: _hasMore,
          ),
        );
      }
    } catch (_) {
      if (loadMore) {
         _emitFromLoaded();
      } else {
        emit(
          const PrescriptionsState.failure(
            message: 'could_not_load_prescriptions',
          ),
        );
      }
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

  void updateSelectedBranch(String value) {
    _selectedBranchId = value;
    _emitFromLoaded();
  }

  Future<bool> createPrescription(PrescriptionModel prescription) async {
    final current = state;

    if (current is! PrescriptionsLoaded) return false;

    final oldPrescriptions = List<PrescriptionModel>.from(_allPrescriptions);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _prescriptionsRepo.createPrescription(prescription);

      _allPrescriptions = [created, ...oldPrescriptions];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPrescriptions = oldPrescriptions;

      emit(
        current.copyWith(
          prescriptions: _filteredPrescriptions,
          isSubmitting: false,
          errorMessage: _prescriptionErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! PrescriptionsLoaded) return false;

    final oldPrescriptions = List<PrescriptionModel>.from(_allPrescriptions);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _prescriptionsRepo.updatePrescriptionFields(id, {'status': status});

      _allPrescriptions = oldPrescriptions.map((item) {
        if (item.id != id) return item;

        return item.copyWith(status: status);
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPrescriptions = oldPrescriptions;

      emit(
        current.copyWith(
          prescriptions: _filteredPrescriptions,
          isSubmitting: false,
          errorMessage: _prescriptionErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _prescriptionErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('patient_name_required')) {
      return 'patient_name_required';
    }

    if (text.contains('doctor_name_required')) {
      return 'doctor_name_required';
    }

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    if (text.contains('prescription_missing_branch')) {
      return 'prescription_missing_branch';
    }

    if (text.contains('prescription_not_found')) {
      return 'prescription_not_found';
    }

    if (text.contains('prescription_already_dispensed')) {
      return 'prescription_already_dispensed';
    }

    if (text.contains('prescription_already_rejected')) {
      return 'prescription_already_rejected';
    }

    if (text.contains('prescription_already_expired')) {
      return 'prescription_already_expired';
    }

    if (text.contains('prescription_not_verified')) {
      return 'prescription_not_verified';
    }

    if (text.contains('invalid_prescription_status_transition')) {
      return 'invalid_prescription_status_transition';
    }

    if (text.contains('prescription_has_no_items')) {
      return 'prescription_has_no_items';
    }

    if (text.contains('prescription_item_missing_medication_id')) {
      return 'prescription_item_missing_medication_id';
    }

    if (text.contains('prescription_item_invalid_quantity')) {
      return 'prescription_item_invalid_quantity';
    }

    if (text.contains('medication_not_found:')) {
      return _errorWithValue(
        text: text,
        token: 'medication_not_found:',
        outputPrefix: 'medication_not_found',
      );
    }

    if (text.contains('inactive_medication:')) {
      return _errorWithValue(
        text: text,
        token: 'inactive_medication:',
        outputPrefix: 'inactive_medication',
      );
    }

    if (text.contains('not_enough_stock_for_medication:')) {
      return _errorWithValue(
        text: text,
        token: 'not_enough_stock_for_medication:',
        outputPrefix: 'not_enough_stock_for_medication',
      );
    }

    if (text.contains('expired_stock_for_medication:')) {
      return _errorWithValue(
        text: text,
        token: 'expired_stock_for_medication:',
        outputPrefix: 'expired_stock_for_medication',
      );
    }

    return 'could_not_update_prescription_status';
  }

  String _errorWithValue({
    required String text,
    required String token,
    required String outputPrefix,
  }) {
    final value = text.split(token).last.replaceAll(']', '').trim();

    return '$outputPrefix|$value';
  }

  Future<bool> deletePrescription(String id) async {
    final current = state;

    if (current is! PrescriptionsLoaded || current.isSubmitting) return false;

    final oldPrescriptions = List<PrescriptionModel>.from(_allPrescriptions);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _prescriptionsRepo.deletePrescription(id);

      _allPrescriptions = oldPrescriptions.where((item) => item.id != id).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allPrescriptions = oldPrescriptions;

      emit(
        current.copyWith(
          prescriptions: _filteredPrescriptions,
          isSubmitting: false,
          errorMessage: 'could_not_delete_prescription',
        ),
      );

      return false;
    }
  }

  List<PrescriptionModel> get _filteredPrescriptions {
    final query = _searchQuery.toLowerCase().trim();

    return _allPrescriptions.where((prescription) {
      final matchSearch =
          query.isEmpty ||
          prescription.patientName.toLowerCase().contains(query) ||
          (prescription.patientPhone?.toLowerCase().contains(query) ?? false) ||
          (prescription.prescriptionNumber?.toLowerCase().contains(query) ??
              false) ||
          (prescription.doctorName?.toLowerCase().contains(query) ?? false) ||
          (prescription.branchName?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == allPrescriptionStatusesValue ||
          prescription.status == _selectedStatus;

      final matchBranch =
          _selectedBranchId == allPrescriptionBranchesValue ||
          prescription.branchId == _selectedBranchId;

      return matchSearch && matchStatus && matchBranch;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is PrescriptionsLoaded) {
      emit(
        current.copyWith(
          prescriptions: _filteredPrescriptions,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
          isSubmitting: false,
          errorMessage: null,
          isLoadingMore: false,
          hasMore: _hasMore,
        ),
      );
    }
  }
}
