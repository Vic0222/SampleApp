import 'package:equatable/equatable.dart';
import 'package:sample_app/models/route.dart';

class GoogleMapsState extends Equatable {
  final Route? route;
  final String errorMessage;

  const GoogleMapsState._({this.route, this.errorMessage = ""});

  const GoogleMapsState.initial() : this._();

  const GoogleMapsState.success(Route route) : this._(route: route);

  const GoogleMapsState.failure(String errorMessage)
      : this._(errorMessage: errorMessage);

  @override
  List<Object?> get props => [route, errorMessage];
}
