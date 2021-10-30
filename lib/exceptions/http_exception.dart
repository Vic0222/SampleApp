class HttpException implements Exception {
  final int statusCode;
  final String message;
  const HttpException(this.statusCode, this.message);
}
