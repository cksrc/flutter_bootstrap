class AuthenticationException implements Exception {
  dynamic error;
  AuthenticationException(this.error);

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
