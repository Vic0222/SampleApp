class DefaultException implements Exception {
  final String message;
  DefaultException(this.message);

  @override
  String toString() {
    return message;
  }
}
