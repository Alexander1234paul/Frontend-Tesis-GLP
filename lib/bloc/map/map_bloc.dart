import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/models/route_destination.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show CameraUpdate, Cap, GoogleMapController, LatLng, Polyline, PolylineId;

import '../../Themes/Uber.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;
  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapIntializeEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isfollowUser: false)));
    on<UpdateUserPolylinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylinesEvent>(
        (event, emit) => emit(state.copyWith(polylines: event.polylines)));

    //
    locationStateSubscription = locationBloc.stream.listen((LocationState) {
      if (LocationState.lastKnowLocation != null) {
        add(UpdateUserPolylinesEvent(LocationState.myLocationHistory));
      }
      //
      if (!state.isfollowUser) return;
      if (LocationState.lastKnowLocation == null) return;
      moveCamera(LocationState.lastKnowLocation!);
    });
  }

  void _onInitMap(OnMapIntializeEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(UberMap));
    emit(state.copyWith(isMapInitialize: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isfollowUser: true));

    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    add(DisplayPolylinesEvent(curretPolylines));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    locationStateSubscription!.cancel();
    return super.close();
  }
}
