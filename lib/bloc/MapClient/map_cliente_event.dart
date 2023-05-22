part of 'map_cliente_bloc.dart';

abstract class MapClienteEvent extends Equatable {
  const MapClienteEvent();

  @override
  List<Object> get props => [];
}

class isTrueSlideEvent extends MapClienteEvent {}
class isFalseSlideEvent extends MapClienteEvent {}

