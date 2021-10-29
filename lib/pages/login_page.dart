import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/authentication/authentication_bloc.dart';
import 'package:sample_app/blocs/authentication/authentication_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _onAuthenticated,
      child: Scaffold(
        body: SafeArea(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Sample App",
                      style: Theme.of(context).textTheme.headline3),
                ),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    child: const Text("Google Sign In"),
                    onPressed: () => _googleSignIn(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _googleSignIn(BuildContext context) {
    context.read<AuthenticationBloc>().googleSignIn();
  }

  void _onAuthenticated(BuildContext context, AuthenticationState state) {
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
