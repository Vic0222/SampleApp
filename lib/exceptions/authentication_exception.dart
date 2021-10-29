class AuthenticationException implements Exception {
  final String code;
  final String message;
  const AuthenticationException(this.code, this.message);
}
