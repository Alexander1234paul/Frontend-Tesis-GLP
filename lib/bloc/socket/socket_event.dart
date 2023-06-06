part of 'socket_bloc.dart';

abstract class SocketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectEvent extends SocketEvent {}

class ConnectionLostEvent extends SocketEvent {}

class getPedidos extends SocketEvent {
  final List<dynamic> pedidos;

  getPedidos(this.pedidos);
       


  @override
  List<Object> get props => [pedidos];
  
}

