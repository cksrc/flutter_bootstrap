class AuthenticationException implements Exception {
  dynamic error;
  AuthenticationException(this.error);

  @override
  String toString() {
    return error.message;
  }
}
