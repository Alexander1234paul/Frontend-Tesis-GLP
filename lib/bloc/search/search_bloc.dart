import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend_tesis_glp/models/places_models.dart';
import 'package:frontend_tesis_glp/models/route_destination.dart';
import 'package:frontend_tesis_glp/services/traffic_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    //Cuando se emite un evento OnActivateManualMarkerEvent, se actualiza el estado del bloque con displayManualMarker en true
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));

//Cuando se emite un evento OnDeactivateManualMarkerEvent, se actualiza el estado del bloque con displayManualMarker en false
    on<OnDeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));

//Cuando se emite un evento OnNewPlacesFoundEvent, se actualiza el estado del bloque con la lista de lugares obtenidos en el evento
    on<OnNewPlacesFoundEvent>(
        (event, emit) => emit(state.copyWith(places: event.places)));

//Cuando se emite un evento AddToHistoryEvent, se actualiza el estado del bloque con el lugar del evento agregado al principio de la lista de historial del estado anterior
    on<AddToHistoryEvent>((event, emit) =>
        emit(state.copyWith(history: [event.place, ...state.history])));
  }

  //La función recibe dos argumentos de tipo LatLng (start y end) y retorna un Future de tipo RouteDestination
  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    //Se llama al método getCoorsStartToEnd del objeto trafficService, el cual también retorna un Future de tipo RouteDestination
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

//Se llama al método getInformationByCoors del objeto trafficService y se le pasa como argumento el valor de end
    final endPlace = await trafficService.getInformationByCoors(end);

//Se obtiene la geometría de la ruta, la distancia y la duración de la respuesta del servicio de tráfico
    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

//Se decodifica la geometría de la ruta utilizando la función decodePolyline, la cual retorna una lista de puntos decodificados
    final points = decodePolyline(geometry, accuracyExponent: 6);

//Se convierte la lista de puntos decodificados en una lista de objetos LatLng y se almacena en la variable latLngList
    final latLngList = points
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();

//Se retorna un objeto RouteDestination con los valores de latLngList, duration, distance y endPlace
    return RouteDestination(
        points: latLngList,
        duration: duration,
        distance: distance,
        endPlace: endPlace);
  }

  //La función recibe dos argumentos, uno de tipo LatLng (proximity) y otro de tipo String (query), y retorna un Future sin un tipo específico.
  Future getPlacesByQuery(LatLng proximity, String query) async {
    //Se llama al método getResultsByQuery del objeto trafficService y se le pasan como argumentos proximity y query
    final newPlaces = await trafficService.getResultsByQuery(proximity, query);

//Se emite un evento OnNewPlacesFoundEvent con el valor de newPlaces
    add(OnNewPlacesFoundEvent(newPlaces));
  }
}
