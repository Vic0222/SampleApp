class User {
  final String id;
  final String displayName;

  const User(this.id, this.displayName);

  static const User empty = User("", "");
}
