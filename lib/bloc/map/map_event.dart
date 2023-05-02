part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapIntializeEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapIntializeEvent(this.controller);
}

class OnStopFollowingUserEvent extends MapEvent {}

class OnStartFollowingUserEvent extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylinesEvent(this.userLocations);
}

class OnToggleUserRoute extends MapEvent {}
