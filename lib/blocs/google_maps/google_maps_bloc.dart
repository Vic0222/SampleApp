import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/services/google_maps_service.dart';

import 'google_maps_event.dart';
import 'google_maps_state.dart';

class GoogleMapsBloc extends Bloc<GoogleMapsEvent, GoogleMapsState> {
  final GoogleMapsService _googleMapsService;
  GoogleMapsBloc(this._googleMapsService)
      : super(const GoogleMapsState.initial()) {
    on<RouteRequestedEvent>(_onRouteRequestedEvent);
  }

  FutureOr<void> _onRouteRequestedEvent(
      RouteRequestedEvent event, Emitter<GoogleMapsState> emit) async {
    try {
      var route = await _googleMapsService.getRandomRoute();
      if (route != null) {
        emit.call(GoogleMapsState.success(route));
      }
    } catch (e) {
      emit.call(GoogleMapsState.failure(e.toString()));
    }
  }

  void requestRoute() {
    add(RouteRequestedEvent());
  }
}
