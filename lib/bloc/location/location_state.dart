part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> myLocationHistory;

  //TODO

  const LocationState(
      {this.followingUser = false, this.lastKnowLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith(
          {bool? followingUser,
          LatLng? lastKnowLocation,
          List<LatLng>? myLocationHistory}) =>
      LocationState(
          followingUser: followingUser ?? this.followingUser,
          lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
          myLocationHistory: myLocationHistory ?? this.myLocationHistory);
  @override
  //Para saber cuando hya unc ambio del state
  List<Object?> get props =>
      [followingUser, lastKnowLocation, myLocationHistory];
}
