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
        _prescriptionsRepo.getMedications(),
      ]);

      _allPrescriptions = results[0] as List<PrescriptionModel>;

      emit(
        PrescriptionsState.loaded(
          prescriptions: _filteredPrescriptions,
          branches: results[1] as dynamic,
          medications: results[2] as dynamic,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        const PrescriptionsState.failure(
          message: 'could_not_load_prescriptions',
        ),
      );
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

    if (text.contains('prescription_not_found')) {
      return 'prescription_not_found';
    }

    if (text.contains('prescription_already_dispensed')) {
      return 'prescription_already_dispensed';
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

    if (text.contains('not_enough_stock_for_medication:')) {
      final medicationName = text
          .split('not_enough_stock_for_medication:')
          .last
          .replaceAll(']', '')
          .trim();

      return 'not_enough_stock_for_medication|$medicationName';
    }

    return 'could_not_update_prescription_status';
  }

  List<PrescriptionModel> get _filteredPrescriptions {
    final query = _searchQuery.toLowerCase().trim();

    return _allPrescriptions.where((prescription) {
      final matchSearch =
          prescription.patientName.toLowerCase().contains(query) ||
          (prescription.patientPhone?.toLowerCase().contains(query) ?? false) ||
          (prescription.prescriptionNumber?.toLowerCase().contains(query) ??
              false) ||
          (prescription.doctorName?.toLowerCase().contains(query) ?? false);

      final matchStatus =
          _selectedStatus == 'all' || prescription.status == _selectedStatus;

      return matchSearch && matchStatus;
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
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
