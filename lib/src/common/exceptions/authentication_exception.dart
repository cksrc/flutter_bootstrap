class AuthenticationException implements Exception {
  dynamic error;
  AuthenticationException(this.error);
}
