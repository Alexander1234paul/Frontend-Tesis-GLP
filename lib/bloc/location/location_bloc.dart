import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

// Define la clase LocationBloc que extiende de la clase Bloc del paquete bloc.
class LocationBloc extends Bloc<LocationEvent, LocationState> {
// Declaración de la variable que contendrá la suscripción a la transmisión de posición.
  StreamSubscription<Position>? positionStream;

// Constructor de la clase LocationBloc, que establece el estado inicial.
  LocationBloc() : super(const LocationState()) {
    // Manejadores de eventos, que actualizan el estado en función de los eventos que se reciban.
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      // Manejador de evento que actualiza la última ubicación conocida y el historial de ubicaciones del usuario.
      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });
  }

// Método que obtiene la ubicación actual del usuario.
  Future getCurrentPosition() async {
    //Obtenemos la ubicacion actual
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

// Método que inicia el seguimiento de la ubicación del usuario.
  void startFollowingUser() {
    add(OnStartFollowingUser());

// Suscripción a la transmisión de posición.
// Obtener las ubicacion cada que cambia
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

// Método que detiene el seguimiento de la ubicación del usuario.
  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
    print('stopFollowingUser');
  }

// Método que se llama automáticamente cuando se cierra el bloque.
  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
