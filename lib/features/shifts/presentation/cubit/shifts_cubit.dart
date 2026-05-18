import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/shift_model.dart';
import '../../data/repos/shifts_repo.dart';
import 'shifts_state.dart';

class ShiftsCubit extends Cubit<ShiftsState> {
  ShiftsCubit({required ShiftsRepo shiftsRepo})
      : _shiftsRepo = shiftsRepo,
        super(const ShiftsState.initial());

  final ShiftsRepo _shiftsRepo;
  List<ShiftModel> _shifts = [];
  DateTime _weekStart = _startOfWeek(DateTime.now());

  Future<void> getShiftsData() async {
    emit(const ShiftsState.loading());
    try {
      final results = await Future.wait([
        _shiftsRepo.getShifts(),
        _shiftsRepo.getStaff(),
        _shiftsRepo.getBranches(),
      ]);
      _shifts = results[0] as List<ShiftModel>;
      emit(ShiftsState.loaded(
        shifts: _shifts,
        staff: results[1] as dynamic,
        branches: results[2] as dynamic,
        weekStart: _weekStart,
      ));
    } catch (error) {
      emit(ShiftsState.failure(message: error.toString()));
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

  Future<void> createShift(ShiftModel shift) async {
    if (state is ShiftsLoaded) emit((state as ShiftsLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _shiftsRepo.createShift(shift);
      _shifts = [..._shifts, created];
      _emitFromLoaded();
    } catch (error) {
      emit(ShiftsState.failure(message: error.toString()));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _shiftsRepo.updateShiftFields(id, {'status': status});
    _shifts = _shifts.map((shift) {
      if (shift.id != id) return shift;
      return ShiftModel.fromJson({...shift.toJson(), 'status': status});
    }).toList();
    _emitFromLoaded();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is ShiftsLoaded) {
      emit(current.copyWith(shifts: _shifts, weekStart: _weekStart, isSubmitting: false));
    }
  }

  static DateTime _startOfWeek(DateTime date) {
    return DateTime(date.year, date.month, date.day).subtract(Duration(days: date.weekday - 1));
  }
}
