import '../data_source/auth_remote_data_source.dart';
import '../models/auth_user_model.dart';

class AuthRepo {
  AuthRepo({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  Stream<dynamic> get authStateChanges => _remoteDataSource.authStateChanges;

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  Future<AuthUserModel> getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }

  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  Future<void> resetPassword({required String email}) {
    return _remoteDataSource.resetPassword(email: email);
  }
}
