import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/auth_user_model.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AuthState.initial()) {
    _authSubscription = _authRepo.authStateChanges.listen(_onAuthChanged);
  }

  final AuthRepo _authRepo;
  StreamSubscription<dynamic>? _authSubscription;
  AuthUserModel? _currentUser;

  AuthUserModel? get currentUser => _currentUser;
  String get currentRole => _currentUser?.role ?? '';
  String get currentBranchId => _currentUser?.branchId ?? '';

  void _onAuthChanged(dynamic user) {
    if (user == null) {
      _currentUser = null;
      emit(const AuthState.unauthenticated());
    } else {
      checkAuthState();
    }
  }

  Future<void> checkAuthState() async {
    emit(const AuthState.loading());

    try {
      _currentUser = await _authRepo.getCurrentUser();
      emit(AuthState.authenticated(user: _currentUser!));
    } catch (_) {
      _currentUser = null;
      emit(const AuthState.unauthenticated());
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    try {
      _currentUser = await _authRepo.signIn(
        email: email,
        password: password,
      );
      emit(AuthState.authenticated(user: _currentUser!));
      return true;
    } catch (error) {
      final message = _mapAuthError(error);
      emit(AuthState.unauthenticated(message: message));
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepo.signOut();
    } catch (_) {}

    _currentUser = null;
    emit(const AuthState.unauthenticated());
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await _authRepo.resetPassword(email: email);
      return true;
    } catch (_) {
      return false;
    }
  }

  String _mapAuthError(Object error) {
    final message = error.toString().toLowerCase();

    if (message.contains('user-not-found') ||
        message.contains('wrong-password') ||
        message.contains('invalid-credential')) {
      return 'invalid_email_or_password';
    }

    if (message.contains('user-disabled')) {
      return 'account_deactivated';
    }

    if (message.contains('too-many-requests')) {
      return 'too_many_attempts';
    }

    if (message.contains('network')) {
      return 'network_error';
    }

    if (message.contains('staff_profile_not_found')) {
      return 'staff_profile_not_found';
    }

    if (message.contains('account_deactivated')) {
      return 'account_deactivated';
    }

    return 'login_failed';
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
