import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_dealer_event.dart';
part 'map_dealer_state.dart';

class MapDealerBloc extends Bloc<MapDealerEvent, MapDealerState> {
  MapDealerBloc() : super(const MapDealerState()) {
    on<locationCliente>((event, emit) =>
        emit(state.copyWith(knownLocationClient: event.newLocation,idDocument: event.idDocument)));
  }
}
