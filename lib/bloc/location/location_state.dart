part of 'location_bloc.dart';

class LocationState extends Equatable {
  // Indica si se está siguiendo al usuario
  final bool followingUser;
  // La última ubicación conocida del usuario
  final LatLng? lastKnownLocation;
  // El historial de ubicaciones del usuario
  final List<LatLng> myLocationHistory;
  
  // Constructor
  const LocationState({
    this.followingUser = false,  // Valor predeterminado es 'false'
    this.lastKnownLocation,     // Puede ser nulo
    myLocationHistory           // Puede ser nulo
  }): myLocationHistory = myLocationHistory ?? const [];  // Si es nulo, crea una lista vacía

  // Crea una nueva instancia de LocationState con los mismos valores, o con algunos nuevos
  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) => LocationState(
    followingUser    : followingUser ?? this.followingUser,
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory,
  );

  // Retorna una lista de objetos que deben ser comparados para determinar si dos objetos LocationState son iguales
  @override
  List<Object?> get props => [ followingUser, lastKnownLocation, myLocationHistory ];
}
