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
      emit(StaffState.loaded(
        staff: _filteredStaff,
        branches: results[1] as dynamic,
        searchQuery: _searchQuery,
        selectedRole: _selectedRole,
      ));
    } catch (error) {
      emit(StaffState.failure(message: error.toString()));
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

  Future<void> createStaff(StaffModel staff) async {
    if (state is StaffLoaded) emit((state as StaffLoaded).copyWith(isSubmitting: true));
    try {
      final created = await _staffRepo.createStaff(staff);
      _allStaff = [created, ..._allStaff];
      _emitFromLoaded();
    } catch (error) {
      emit(StaffState.failure(message: error.toString()));
    }
  }

  Future<void> updateStaff(StaffModel staff) async {
    if (state is StaffLoaded) emit((state as StaffLoaded).copyWith(isSubmitting: true));
    try {
      final updated = await _staffRepo.updateStaff(staff);
      _allStaff = _allStaff.map((item) => item.id == updated.id ? updated : item).toList();
      _emitFromLoaded();
    } catch (error) {
      emit(StaffState.failure(message: error.toString()));
    }
  }

  List<StaffModel> get _filteredStaff {
    final query = _searchQuery.toLowerCase();
    return _allStaff.where((member) {
      final matchSearch = member.fullName.toLowerCase().contains(query) || member.email.toLowerCase().contains(query);
      final matchRole = _selectedRole == 'all' || member.role == _selectedRole;
      return matchSearch && matchRole;
    }).toList();
  }

  void _emitFromLoaded() {
    final current = state;
    if (current is StaffLoaded) {
      emit(current.copyWith(
        staff: _filteredStaff,
        searchQuery: _searchQuery,
        selectedRole: _selectedRole,
        isSubmitting: false,
      ));
    }
  }
}
