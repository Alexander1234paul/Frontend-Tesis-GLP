part of 'map_bloc.dart';

// Clase que extiende Equatable
class MapState extends Equatable {
  // Atributos finales que representan el estado del mapa
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  // Polilíneas y marcadores
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  // Constructor constante que toma argumentos opcionales
  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })   : // Asigna polilíneas y marcadores a los valores predeterminados si son nulos
        polylines = polylines ?? const {},
        markers = markers ?? const {};

  // Método que devuelve una nueva instancia de MapState con los atributos proporcionados
  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        // Asigna los valores proporcionados o los valores existentes si son nulos
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
      );

  // Método que devuelve una lista de los atributos que se deben considerar en la igualdad de instancias de MapState
  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showMyRoute, polylines, markers];
}
