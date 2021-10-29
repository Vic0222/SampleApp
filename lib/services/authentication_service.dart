import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sample_app/exceptions/authentication_exception.dart';
import 'package:sample_app/models/authentication_status.dart';
import 'package:sample_app/models/user.dart' as model_user;

class AuthentiationService {
  final StreamController<AuthenticationStatus> statusStream =
      StreamController<AuthenticationStatus>();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthentiationService(this._firebaseAuth, this._googleSignIn);

  FutureOr<model_user.User> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var userCredential = await _firebaseAuth.signInWithCredential(credential);

      return model_user.User(userCredential.user?.uid ?? "",
          userCredential.user?.displayName ?? "");
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw AuthenticationException(e.code, e.message ?? "");
    }
  }
}
