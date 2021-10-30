import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionStepsService {
  final DirectionsService _directionsService;
  DirectionStepsService(this._directionsService);

  getDirectionSteps(LatLng start, LatLng destination) async {
    final request = DirectionsRequest(
      origin: "${start.latitude},${start.longitude}",
      destination: "${destination.latitude},${destination.longitude}",
      travelMode: TravelMode.driving,
    );

    await _directionsService.route(request,
        (DirectionsResult response, DirectionsStatus? status) {
      if (status == DirectionsStatus.ok) {
        // do something with successful response
      } else {
        // do something with error response
      }
    });
  }
}
