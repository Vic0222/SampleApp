import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/exceptions/authentication_exception.dart';
import 'package:sample_app/services/authentication_service.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthentiationService _authentiationService;
  AuthenticationBloc(AuthentiationService authentiationService)
      : _authentiationService = authentiationService,
        super(const AuthenticationState.unauthenticated()) {
    on<GoogleSignInRequested>(_onAuthenticationRequested);
  }

  FutureOr<void> _onAuthenticationRequested(
      GoogleSignInRequested event, Emitter<AuthenticationState> emit) async {
    try {
      var user = await _authentiationService.googleSignIn();
      emit.call(AuthenticationState.authenticated(user));
    } on AuthenticationException catch (ex) {
      emit.call(AuthenticationState.authenticationFailed(ex.message));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void googleSignIn() {
    add(GoogleSignInRequested());
  }
}
