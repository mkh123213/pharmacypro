import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/staff_model.dart';
import '../../data/repos/staff_repo.dart';
import 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffCubit({required StaffRepo staffRepo})
    : _staffRepo = staffRepo,
      super(const StaffState.initial());

  final StaffRepo _staffRepo;

  List<StaffModel> _allStaff = [];
  String _searchQuery = '';
  String _selectedRole = 'all';

  Future<void> getStaffData() async {
    emit(const StaffState.loading());

    try {
      final results = await Future.wait([
        _staffRepo.getStaff(),
        _staffRepo.getBranches(),
      ]);

      _allStaff = results[0] as List<StaffModel>;

      emit(
        StaffState.loaded(
          staff: _filteredStaff,
          branches: results[1] as dynamic,
          searchQuery: _searchQuery,
          selectedRole: _selectedRole,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(const StaffState.failure(message: 'could_not_load_staff_data'));
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _emitFromLoaded();
  }

  void updateSelectedRole(String value) {
    _selectedRole = value;
    _emitFromLoaded();
  }

  Future<bool> createStaff(StaffModel staff) async {
    final current = state;

    if (current is! StaffLoaded) return false;

    final oldStaff = List<StaffModel>.from(_allStaff);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final created = await _staffRepo.createStaff(staff);

      _allStaff = [created, ...oldStaff];

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allStaff = oldStaff;

      emit(
        current.copyWith(
          staff: _filteredStaff,
          isSubmitting: false,
          errorMessage: _staffErrorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> updateStaff(StaffModel staff) async {
    final current = state;

    if (current is! StaffLoaded) return false;

    final oldStaff = List<StaffModel>.from(_allStaff);

    emit(current.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final updated = await _staffRepo.updateStaff(staff);

      _allStaff = oldStaff.map((item) {
        return item.id == updated.id ? updated : item;
      }).toList();

      _emitFromLoaded();

      return true;
    } catch (error) {
      _allStaff = oldStaff;

      emit(
        current.copyWith(
          staff: _filteredStaff,
          isSubmitting: false,
          errorMessage: _staffErrorMessage(error),
        ),
      );

      return false;
    }
  }

  String _staffErrorMessage(Object error) {
    final text = error.toString();

    if (text.contains('staff_not_found')) {
      return 'staff_not_found';
    }

    if (text.contains('staff_name_required')) {
      return 'staff_name_required';
    }

    if (text.contains('staff_email_required')) {
      return 'staff_email_required';
    }

    if (text.contains('staff_invalid_email')) {
      return 'staff_invalid_email';
    }

    if (text.contains('staff_email_already_exists')) {
      return 'staff_email_already_exists';
    }

    if (text.contains('staff_role_required')) {
      return 'staff_role_required';
    }

    if (text.contains('staff_invalid_role')) {
      return 'staff_invalid_role';
    }

    if (text.contains('staff_branch_required')) {
      return 'staff_branch_required';
    }

    if (text.contains('staff_invalid_phone')) {
      return 'staff_invalid_phone';
    }

    if (text.contains('staff_invalid_hire_date')) {
      return 'staff_invalid_hire_date';
    }

    if (text.contains('branch_not_found')) {
      return 'branch_not_found';
    }

    if (text.contains('inactive_branch')) {
      return 'inactive_branch';
    }

    return 'could_not_save_staff_member';
  }

  List<StaffModel> get _filteredStaff {
    final query = _searchQuery.toLowerCase().trim();

    return _allStaff.where((member) {
      final matchSearch =
          query.isEmpty ||
          member.fullName.toLowerCase().contains(query) ||
          member.email.toLowerCase().contains(query) ||
          (member.phone?.toLowerCase().contains(query) ?? false) ||
          (member.branchName?.toLowerCase().contains(query) ?? false);

      final matchRole = _selectedRole == 'all' || member.role == _selectedRole;

      return matchSearch && matchRole;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;

    if (current is StaffLoaded) {
      emit(
        current.copyWith(
          staff: _filteredStaff,
          searchQuery: _searchQuery,
          selectedRole: _selectedRole,
          isSubmitting: false,
          errorMessage: null,
        ),
      );
    }
  }
}
