import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/shift_model.dart';
import '../../data/repos/shifts_repo.dart';
import '../refactor/shifts_constants.dart';
import 'shifts_state.dart';

class ShiftsCubit extends Cubit<ShiftsState> {
  ShiftsCubit({required ShiftsRepo shiftsRepo})
    : _shiftsRepo = shiftsRepo,
      super(const ShiftsState.initial());

  final ShiftsRepo _shiftsRepo;

  List<ShiftModel> _allShifts = [];
  DateTime _weekStart = _startOfWeek(DateTime.now());

  String _searchQuery = '';
  String _selectedStatus = allShiftStatusesValue;
  String _selectedBranchId = allShiftBranchesValue;
  String _selectedStaffId = allShiftStaffValue;

  Future<void> getShiftsData() async {
    emit(const ShiftsState.loading());

    try {
      final results = await Future.wait([
        _shiftsRepo.getShifts(),
        _shiftsRepo.getStaff(),
        _shiftsRepo.getBranches(),
      ]);

      _allShifts = results[0] as List<ShiftModel>;

      emit(
        ShiftsState.loaded(
          shifts: _filteredShifts,
          staff: results[1] as dynamic,
          branches: results[2] as dynamic,
          weekStart: _weekStart,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
          selectedStaffId: _selectedStaffId,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(const ShiftsState.failure(message: 'could_not_load_shifts'));
    }
  }

  void previousWeek() {
    _weekStart = _weekStart.subtract(const Duration(days: 7));
    _emitFromLoaded();
  }

  void nextWeek() {
    _weekStart = _weekStart.add(const Duration(days: 7));
    _emitFromLoaded();
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

  void updateSelectedStaff(String value) {
    _selectedStaffId = value;
    _emitFromLoaded();
  }

  Future<bool> createShift(ShiftModel shift) async {
    final current = state;

    if (current is! ShiftsLoaded) return false;

    final oldShifts = List<ShiftModel>.from(_allShifts);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _shiftsRepo.createShift(shift);

      _allShifts = [...oldShifts, created];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allShifts = oldShifts;

      emit(
        current.copyWith(
          shifts: _filteredShifts,
          isSubmitting: false,
          errorMessage: _shiftErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! ShiftsLoaded) return false;

    final oldShifts = List<ShiftModel>.from(_allShifts);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _shiftsRepo.updateShiftFields(id, {'status': status});

      _allShifts = oldShifts.map((shift) {
        if (shift.id != id) return shift;

        return ShiftModel.fromJson({...shift.toJson(), 'status': status});
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allShifts = oldShifts;

      emit(
        current.copyWith(
          shifts: _filteredShifts,
          isSubmitting: false,
          errorMessage: _shiftErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _shiftErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('shift_not_found')) {
      return 'shift_not_found';
    }

    if (text.contains('staff_not_found')) {
      return 'staff_not_found';
    }

    if (text.contains('inactive_staff')) {
      return 'inactive_staff';
    }

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    if (text.contains('shift_missing_staff')) {
      return 'shift_missing_staff';
    }

    if (text.contains('shift_missing_branch')) {
      return 'shift_missing_branch';
    }

    if (text.contains('shift_invalid_date')) {
      return 'shift_invalid_date';
    }

    if (text.contains('shift_invalid_time')) {
      return 'shift_invalid_time';
    }

    if (text.contains('shift_end_time_must_be_after_start_time')) {
      return 'shift_end_time_must_be_after_start_time';
    }

    if (text.contains('shift_already_completed')) {
      return 'shift_already_completed';
    }

    if (text.contains('shift_already_cancelled')) {
      return 'shift_already_cancelled';
    }

    if (text.contains('cannot_cancel_completed_shift')) {
      return 'cannot_cancel_completed_shift';
    }

    if (text.contains('invalid_shift_status_transition')) {
      return 'invalid_shift_status_transition';
    }

    return 'could_not_save_shift';
  }

  List<ShiftModel> get _filteredShifts {
    final query = _searchQuery.toLowerCase().trim();

    return _allShifts.where((shift) {
      final matchSearch =
          query.isEmpty ||
          (shift.staffName?.toLowerCase().contains(query) ?? false) ||
          (shift.branchName?.toLowerCase().contains(query) ?? false) ||
          shift.date.toLowerCase().contains(query) ||
          shift.startTime.toLowerCase().contains(query) ||
          shift.endTime.toLowerCase().contains(query);

      final matchStatus =
          _selectedStatus == allShiftStatusesValue ||
          shift.status == _selectedStatus;

      final matchBranch =
          _selectedBranchId == allShiftBranchesValue ||
          shift.branchId == _selectedBranchId;

      final matchStaff =
          _selectedStaffId == allShiftStaffValue ||
          shift.staffId == _selectedStaffId;

      return matchSearch && matchStatus && matchBranch && matchStaff;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is ShiftsLoaded) {
      emit(
        current.copyWith(
          shifts: _filteredShifts,
          weekStart: _weekStart,
          searchQuery: _searchQuery,
          selectedStatus: _selectedStatus,
          selectedBranchId: _selectedBranchId,
          selectedStaffId: _selectedStaffId,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }

  static DateTime _startOfWeek(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday - 1));
  }
}
