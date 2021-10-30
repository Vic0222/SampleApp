import 'package:equatable/equatable.dart';
import 'package:sample_app/models/user.dart';

enum AuthenticationStatus {
  unauthenticated,
  authenticating,
  authenticated,
  unauthenticating,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unauthenticated,
    this.user = User.empty,
    this.errorMessage = "",
  });

  const AuthenticationState.unauthenticated() : this._();

  const AuthenticationState.authenticationFailed(String errorMessage)
      : this._(errorMessage: errorMessage);

  const AuthenticationState.authenticating()
      : this._(status: AuthenticationStatus.authenticating);

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticating()
      : this._(status: AuthenticationStatus.unauthenticating);

  final AuthenticationStatus status;
  final User user;
  final String errorMessage;

  @override
  List<Object> get props => [status, user, errorMessage];
}
