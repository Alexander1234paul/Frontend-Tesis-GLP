import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_cliente_event.dart';
part 'map_cliente_state.dart';
class MapClienteBloc extends Bloc<MapClienteEvent, MapClienteState> {
  MapClienteBloc() : super(const MapClienteState()) {
    on<isTrueSlideEvent>((event, emit) => emit(state.copyWith(isSlide: true)));
    on<isFalseSlideEvent>((event, emit) => emit(state.copyWith(isSlide: false)));
  }
}
