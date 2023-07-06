part of 'map_dealer_bloc.dart';

abstract class MapDealerEvent extends Equatable {
  const MapDealerEvent();

  @override
  List<Object> get props => [];
}
class locationCliente extends MapDealerEvent {
  final LatLng newLocation;
  final String idDocument;
  
  const locationCliente(this.newLocation, this.idDocument);
}
