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

      emit(
        ShiftsState.loaded(
          shifts: _shifts,
          staff: results[1] as dynamic,
          branches: results[2] as dynamic,
          weekStart: _weekStart,
        ),
      );
    } catch (error) {
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

  Future<bool> createShift(ShiftModel shift) async {
    final current = state;

    if (current is! ShiftsLoaded) return false;

    final oldShifts = List<ShiftModel>.from(_shifts);

    emit(current.copyWith(isSubmitting: true));

    try {
      final created = await _shiftsRepo.createShift(shift);

      _shifts = [...oldShifts, created];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _shifts = oldShifts;

      emit(current.copyWith(shifts: _shifts, isSubmitting: false));

      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    final current = state;

    if (current is! ShiftsLoaded) return false;

    final oldShifts = List<ShiftModel>.from(_shifts);

    emit(current.copyWith(isSubmitting: true));

    try {
      await _shiftsRepo.updateShiftFields(id, {'status': status});

      _shifts = oldShifts.map((shift) {
        if (shift.id != id) return shift;

        return ShiftModel.fromJson({...shift.toJson(), 'status': status});
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _shifts = oldShifts;

      emit(current.copyWith(shifts: _shifts, isSubmitting: false));

      return false;
    }
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is ShiftsLoaded) {
      emit(
        current.copyWith(
          shifts: _shifts,
          weekStart: _weekStart,
          isSubmitting: false,
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
