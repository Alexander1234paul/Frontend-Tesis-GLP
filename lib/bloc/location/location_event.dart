part of 'location_bloc.dart';

// Clase abstracta para eventos de ubicación
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

// Evento para la nueva ubicación del usuario
class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;
  const OnNewUserLocationEvent(this.newLocation);
}

// Evento para iniciar el seguimiento del usuario
class OnStartFollowingUser extends LocationEvent {}

// Evento para detener el seguimiento del usuario
class OnStopFollowingUser extends LocationEvent {}
