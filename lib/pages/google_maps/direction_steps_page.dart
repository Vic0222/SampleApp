import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_directions_api/google_directions_api.dart'
    as direction_api;

class DirectionStepsPage extends StatelessWidget {
  final List<direction_api.Step> steps;

  const DirectionStepsPage(this.steps, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direction Instructions"),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.black),
          itemCount: steps.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Text((i + 1).toString()),
              title: Html(data: steps[i].instructions ?? "???"),
            );
          }),
    );
  }
}
