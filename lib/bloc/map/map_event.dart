part of 'map_bloc.dart';

// Clase abstracta que extiende Equatable
abstract class MapEvent extends Equatable {
  // Constructor constante
  const MapEvent();

  // Implementación de método props
  @override
  List<Object> get props => [];
}

// Clase que extiende MapEvent y representa el evento de inicialización del mapa
class OnMapInitialzedEvent extends MapEvent {
  // Atributo final que representa el controlador del mapa de tipo GoogleMapController
  final GoogleMapController controller;
  // Constructor constante que toma un argumento controlador
  const OnMapInitialzedEvent(this.controller);
}

// Clase que extiende MapEvent y representa el evento de dejar de seguir al usuario
class OnStopFollowingUserEvent extends MapEvent {}

// Clase que extiende MapEvent y representa el evento de empezar a seguir al usuario
class OnStartFollowingUserEvent extends MapEvent {}

// Clase que extiende MapEvent y representa el evento de actualización de la polilínea del usuario
class UpdateUserPolylineEvent extends MapEvent {
  // Atributo final que representa la lista de ubicaciones del usuario de tipo LatLng
  final List<LatLng> userLocations;
  // Constructor constante que toma un argumento de ubicaciones del usuario
  const UpdateUserPolylineEvent(this.userLocations);
}

// Clase que extiende MapEvent y representa el evento de cambiar la ruta del usuario
class OnToggleUserRoute extends MapEvent {}

// Clase que extiende MapEvent y representa el evento de mostrar varias polilíneas y marcadores
class DisplayPolylinesEvent extends MapEvent {
  // Atributo final que representa un mapa de polilíneas
  final Map<String, Polyline> polylines;
  // Atributo final que representa un mapa de marcadores
  final Map<String, Marker> markers;
  // Constructor constante que toma un mapa de polilíneas y un mapa de marcadores
  const DisplayPolylinesEvent(this.polylines, this.markers);
}
