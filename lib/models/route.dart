import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Route {
  final Polyline polyline;
  final GeoCoordBounds? bounds;

  Route(this.polyline, this.bounds);
}
