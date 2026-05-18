import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/shift_model.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';

part 'shifts_state.freezed.dart';

@freezed
class ShiftsState with _$ShiftsState {
  const factory ShiftsState.initial() = ShiftsInitial;
  const factory ShiftsState.loading() = ShiftsLoading;
  const factory ShiftsState.loaded({
    required List<ShiftModel> shifts, required List<StaffModel> staff, required List<BranchModel> branches, required DateTime weekStart, @Default(false) bool isSubmitting,
  }) = ShiftsLoaded;
  const factory ShiftsState.failure({required String message}) = ShiftsFailure;
}
