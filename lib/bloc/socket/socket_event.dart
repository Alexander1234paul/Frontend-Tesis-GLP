part of 'socket_bloc.dart';
abstract class SocketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectEvent extends SocketEvent {}

class ConnectionLostEvent extends SocketEvent {}

class GetPedidosEvent extends SocketEvent {
  final List<dynamic> pedidos;

  GetPedidosEvent(this.pedidos);

  @override
  List<Object?> get props => [pedidos];
}
class ListaPedidosEvent extends SocketEvent {
  List<dynamic> pedidos;

  ListaPedidosEvent(this.pedidos);
}