part of 'map_dealer_bloc.dart';

class MapDealerState extends Equatable {
  final LatLng? knownLocationClient;

  const MapDealerState({this.knownLocationClient});
  MapDealerState copyWith({
    LatLng? knownLocationClient,
  }) =>
      MapDealerState(
        knownLocationClient: knownLocationClient ?? this.knownLocationClient,
      );
  @override
  List<Object> get props => [];
}
