import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sample_app/blocs/google_maps/google_maps_bloc.dart';
import 'package:sample_app/blocs/google_maps/google_maps_state.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  static const CameraPosition _startingPosition = CameraPosition(
    target: LatLng(10.6937, 122.5404),
    zoom: 14.4746,
  );

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final Completer<GoogleMapController> _controller = Completer();

  List<Polyline> _polilynes = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleMapsBloc, GoogleMapsState>(
      listener: (context, state) {
        var route = state.route;
        if (route != null) {
          setState(() {
            _polilynes.add(route.polyline);
          });
        }
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: GoogleMapsPage._startingPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            polylines: Set<Polyline>.of(_polilynes),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<GoogleMapsBloc>().requestRoute();
          },
        ),
      ),
    );
  }
}
