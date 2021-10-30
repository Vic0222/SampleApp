import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                child: const Text("Top Hacker News"),
                onPressed: () => _goToHackNews(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToHackNews(BuildContext context) {
    Navigator.of(context).pushNamed("/hacker_news");
  }
}
