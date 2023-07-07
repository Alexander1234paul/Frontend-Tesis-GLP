part of 'map_dealer_bloc.dart';

class MapDealerState extends Equatable {
  final LatLng? knownLocationClient;
  final String? idDocument;
  final bool? isSlide;

  const MapDealerState(
      {this.idDocument, this.knownLocationClient, this.isSlide=false});

  MapDealerState copyWith({
    LatLng? knownLocationClient,
    String? idDocument,
    bool? isSlide,
  }) {
    return MapDealerState(
      knownLocationClient: knownLocationClient ?? this.knownLocationClient,
      idDocument: idDocument ?? this.idDocument,
      isSlide: isSlide ?? this.isSlide,
    );
  }

  @override
  List<Object?> get props => [knownLocationClient, idDocument, isSlide];
}
