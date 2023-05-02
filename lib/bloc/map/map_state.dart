part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialize;
  final bool isfollowUser;
  final bool showMyRoute;

  //Polilynes
  final Map<String, Polyline> polylines;
  const MapState(
      {this.isMapInitialize = false,
      this.isfollowUser = true,
      this.showMyRoute = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapInitialize,
          bool? isfollowUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
        isMapInitialize: isMapInitialize ?? this.isMapInitialize,
        isfollowUser: isfollowUser ?? this.isfollowUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
      );
  @override
  List<Object> get props => [
        isMapInitialize,
        isfollowUser,
        showMyRoute,
        polylines,
      ];
}
