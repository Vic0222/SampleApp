import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'
    as flutter_polyline_points;
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sample_app/exceptions/default_exception.dart';
import 'package:sample_app/models/route.dart' as route_ns;

class GoogleMapsService {
  final Location _location;
  final DirectionsService _directionsService;
  final flutter_polyline_points.PolylinePoints _polylinePoints;

  GoogleMapsService(
      this._polylinePoints, this._directionsService, this._location);

  FutureOr<LatLng> getLocation() async {
    var location = await _location.getLocation();
    return LatLng(location.latitude ?? 0, location.longitude ?? 0);
  }

  FutureOr<route_ns.Route?> getRandomRoute() async {
    var start = await getLocation();
    var destination =
        await _getRandomLocation(LatLng(start.latitude, start.longitude));
    return _createPolyline(start.latitude, start.longitude,
        destination.latitude, destination.longitude);
  }

  FutureOr<route_ns.Route?> _createPolyline(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    final request = DirectionsRequest(
      origin: "$startLatitude,$startLongitude",
      destination: "$destinationLatitude,$destinationLongitude",
      travelMode: TravelMode.driving,
    );

    route_ns.Route? route;

    await _directionsService.route(request,
        (DirectionsResult response, DirectionsStatus? status) {
      if (status == DirectionsStatus.ok) {
        route = response.routes?.map((route) {
          var polyline = _polylinePoints
              .decodePolyline(route.overviewPolyline?.points ?? "");
          var points =
              polyline.map((e) => LatLng(e.latitude, e.longitude)).toList();
          return route_ns.Route(
              Polyline(
                polylineId: const PolylineId("random-route"),
                points: points,
                width: 10,
                color: Colors.blue,
              ),
              route.bounds,
              route.legs ?? List.empty());
        }).first;
      } else {
        throw DefaultException(status.toString());
      }
    });
    return route;
  }

  FutureOr<LatLng> _getRandomLocation(LatLng start) async {
    double radius = 10 * 1000; //radius in meters

    //This is to generate 10 random points
    double x0 = start.latitude;
    double y0 = start.longitude;

    Random random = Random();

    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000;

    double u = random.nextDouble();
    double v = random.nextDouble();

    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t);

    // Adjust the x-coordinate for the shrinking of the east-west distances
    double newX = x / cos(y0);

    double foundLatitude = newX + x0;
    double foundLongitude = y + y0;
    return LatLng(foundLatitude, foundLongitude);
  }
}
