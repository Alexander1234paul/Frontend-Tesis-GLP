part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialize;
  final bool followUser;
  const MapState({this.isMapInitialize = false, this.followUser = false});

  MapState copyWith({bool? isMapInitialize, bool? followUser}) => MapState(
        isMapInitialize: isMapInitialize ?? this.isMapInitialize,
        followUser: followUser ?? this.followUser,
      );
  @override
  List<Object> get props => [isMapInitialize, followUser];
}
