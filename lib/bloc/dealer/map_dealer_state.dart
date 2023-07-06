part of 'map_dealer_bloc.dart';
class MapDealerState extends Equatable {
  final LatLng? knownLocationClient;
  final String? idDocument;

  const MapDealerState({this.idDocument, this.knownLocationClient});

  MapDealerState copyWith({
    LatLng? knownLocationClient,
    String? idDocument,
  }) {
    return MapDealerState(
      knownLocationClient: knownLocationClient ?? this.knownLocationClient,
      idDocument: idDocument ?? this.idDocument,
    );
  }

  @override
  List<Object?> get props => [knownLocationClient, idDocument];
}
