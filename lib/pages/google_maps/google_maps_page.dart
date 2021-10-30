import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sample_app/blocs/google_maps/google_maps_bloc.dart';
import 'package:sample_app/blocs/google_maps/google_maps_state.dart';
import 'package:sample_app/services/google_maps_service.dart';

import 'direction_steps_page.dart';

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

  final List<Polyline> _polilynes = List.empty(growable: true);
  final List<Marker> _markers = List.empty(growable: true);

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
            _polilynes.add(route.polyline.copyWith(
              consumeTapEventsParam: true,
              onTapParam: () {
                if (route.legs.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => DirectionStepsPage(
                              route.legs.first.steps ?? List.empty(),
                            )),
                  );
                }
              },
            ));

            if (route.polyline.points.isNotEmpty) {
              var startMarker = Marker(
                markerId: const MarkerId("start"),
                position: route.polyline.points[0],
              );

              var destinationMarker = Marker(
                markerId: const MarkerId("destination"),
                position:
                    route.polyline.points[route.polyline.points.length - 1],
              );

              _markers.add(startMarker);
              _markers.add(destinationMarker);
            }
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
        appBar: AppBar(
          title: const Text("Google Maps"),
        ),
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: GoogleMapsPage._startingPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            polylines: Set<Polyline>.of(_polilynes),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);

              controller.animateCamera(CameraUpdate.newLatLng(
                  await context.read<GoogleMapsService>().getLocation()));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            context.read<GoogleMapsBloc>().requestRoute();
          },
        ),
      ),
    );
  }
}
