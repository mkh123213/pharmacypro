class ErrorMapper {
  ErrorMapper._();

  static String mapException(Object error) {
    final message = error.toString();

    if (message.contains('Exception: ')) {
      final key = message.replaceFirst('Exception: ', '');

      if (key.contains(':')) {
        return key.split(':').first;
      }

      return key;
    }

    if (message.contains('firebase_auth')) {
      return _mapFirebaseAuthError(message);
    }

    if (message.contains('cloud_firestore')) {
      return _mapFirestoreError(message);
    }

    if (message.contains('SocketException') ||
        message.contains('NetworkException') ||
        message.contains('network')) {
      return 'network_error';
    }

    return 'unknown_error';
  }

  static String? extractParam(Object error) {
    final message = error.toString();

    if (message.contains('Exception: ') && message.contains(':')) {
      final key = message.replaceFirst('Exception: ', '');
      final parts = key.split(':');

      if (parts.length > 1) {
        return parts.sublist(1).join(':');
      }
    }

    return null;
  }

  static String _mapFirebaseAuthError(String message) {
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

    if (message.contains('email-already-in-use')) {
      return 'email_already_in_use';
    }

    return 'login_failed';
  }

  static String _mapFirestoreError(String message) {
    if (message.contains('permission-denied')) {
      return 'no_permission';
    }

    if (message.contains('not-found')) {
      return 'not_found';
    }

    if (message.contains('unavailable')) {
      return 'network_error';
    }

    return 'unknown_error';
  }
}
