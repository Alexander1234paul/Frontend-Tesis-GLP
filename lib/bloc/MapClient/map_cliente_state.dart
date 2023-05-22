part of 'map_cliente_bloc.dart';

class MapClienteState extends Equatable {
  final bool isSlide;

  const MapClienteState({this.isSlide = false});

  MapClienteState copyWith({bool? isSlide}) =>
      MapClienteState(isSlide: isSlide ?? this.isSlide);

  @override
  List<Object> get props => [isSlide];
}
