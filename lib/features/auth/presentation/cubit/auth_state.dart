import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/auth_user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated({required AuthUserModel user}) =
      AuthAuthenticated;
  const factory AuthState.unauthenticated({String? message}) =
      AuthUnauthenticated;
}
