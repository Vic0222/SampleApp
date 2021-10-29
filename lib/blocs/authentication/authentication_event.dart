import 'package:equatable/equatable.dart';
import 'package:sample_app/models/authentication_status.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class GoogleSignInRequested extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
