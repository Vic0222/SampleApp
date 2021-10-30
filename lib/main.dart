import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/login_page.dart';
import 'package:sample_app/services/hacker_news_service.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/top_news_list/top_news_list_bloc.dart';
import 'pages/hacker_news/hacker_news_page.dart';
import 'services/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  remoteConfigDefaults();
  runApp(const MyApp());
}

void remoteConfigDefaults() {
  RemoteConfig.instance.setDefaults(<String, dynamic>{
    'hacker_news_base_address': 'hacker-news.firebaseio.com'
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthentiationService>(
            create: (context) =>
                AuthentiationService(FirebaseAuth.instance, GoogleSignIn()),
          ),
          RepositoryProvider<HackerNewsService>(
            create: (context) =>
                HackerNewsService(Client(), RemoteConfig.instance),
          ),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    AuthenticationBloc(context.read<AuthentiationService>()),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              initialRoute: '/login',
              routes: {
                '/login': (context) => const LoginPage(),
                '/home': (context) => const HomePage(),
                '/hacker_news': (context) => BlocProvider(
                      create: (context) =>
                          TopNewsListBloc(context.read<HackerNewsService>()),
                      child: const HackerNewsPage(),
                    ),
              },
            )));
  }
}
