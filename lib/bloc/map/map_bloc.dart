import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/helpers/widgets_to_marker.dart';
import 'package:frontend_tesis_glp/models/route_destination.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show
        CameraUpdate,
        Cap,
        GoogleMapController,
        LatLng,
        Marker,
        MarkerId,
        Polyline,
        PolylineId;

import '../../Themes/Uber.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc; // Instancia del bloc de ubicación
  GoogleMapController? _mapController; // Controlador del mapa de Google
  LatLng? mapCenter; // Centro del mapa

  StreamSubscription<LocationState>?
      locationStateSubscription; // Suscripción a los eventos de ubicación

  // Constructor
  MapBloc({required this.locationBloc}) : super(const MapState()) {
    // Evento para inicializar el mapa
    on<OnMapInitialzedEvent>(_onInitMap);
    // Evento para empezar a seguir al usuario
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    // Evento para dejar de seguir al usuario
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));
    // Evento para actualizar la ruta del usuario
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    // Evento para mostrar/ocultar la ruta del usuario
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    // Evento para mostrar polilíneas en el mapa
    on<DisplayPolylinesEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));

    // Suscripción a los eventos de ubicación
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });
  }

  // Método para inicializar el mapa
  void _onInitMap(OnMapInitialzedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller; // Se guarda el controlador del mapa
    _mapController!.setMapStyle(
        jsonEncode(UberMap)); // Se aplica un estilo personalizado al mapa

    emit(state.copyWith(
        isMapInitialized:
            true)); // Se actualiza el estado del mapa para indicar que ya se inicializó
  }

  // Método para empezar a seguir al usuario
  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(
        isFollowingUser:
            true)); // Se actualiza el estado del mapa para indicar que se está siguiendo al usuario

    // Si no se tiene la última ubicación conocida del usuario, se detiene el método
    if (locationBloc.state.lastKnownLocation == null) return;

    // Si se tiene la última ubicación conocida del usuario, se mueve la cámara a esa ubicación
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

// Esta función se ejecuta cuando se recibe un evento de actualización de la ubicación del usuario y se debe actualizar la polilínea en el mapa.
  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
// Se crea una nueva polilínea con los puntos de ubicación del usuario y se configuran sus propiedades.
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

// Se crea una copia del mapa actual de polilíneas en el estado.
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
// Se actualiza o agrega la nueva polilínea a la copia del mapa de polilíneas.
    currentPolylines['myRoute'] = myRoute;

// Se actualiza el estado con el nuevo mapa de polilíneas que incluye la nueva polilínea creada.
    emit(state.copyWith(polylines: currentPolylines));
  }

  // Esta función dibuja una ruta en un mapa con marcadores personalizados
// según la ubicación inicial y final de la ruta.
  Future drawRoutePolyline(RouteDestination destination) async {
// Crea una instancia de Polyline con los puntos de la ruta y sus atributos.
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
// Calcula la distancia de la ruta en kilómetros.
    double kms = destination.distance / 1000;
// Redondea a dos decimales.
    kms = (kms * 100).floorToDouble();
    kms /= 100;

// Calcula la duración del viaje en minutos.
    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

// Crea marcadores personalizados para el inicio y final de la ruta.
    final startMaker = await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final endMaker =
        await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

// Crea una instancia de Marker para el inicio de la ruta.
    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      icon: startMaker,
      position: destination.points.first,
    );

// Crea una instancia de Marker para el final de la ruta.
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
    );

// Actualiza las instancias de Polyline y Marker en el estado del mapa.
    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

// Agrega el evento DisplayPolylinesEvent con las nuevas instancias al estado del mapa.
    add(DisplayPolylinesEvent(curretPolylines, currentMarkers));
  }

// Esta función recibe una nueva ubicación en formato LatLng
  void moveCamera(LatLng newLocation) {
// Crea un objeto CameraUpdate con la nueva ubicación
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
// Anima la cámara del mapa hacia la nueva ubicación
    _mapController?.animateCamera(cameraUpdate);
  }

// Esta función se ejecuta cuando se cierra el Bloc y cancela la suscripción a locationStateSubscription
  @override
  Future<void> close() {
// Cancela la suscripción a locationStateSubscription si no es null
    locationStateSubscription?.cancel();
// Llama a la función close del Bloc
    return super.close();
  }
}
