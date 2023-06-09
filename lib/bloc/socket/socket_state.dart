part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final ServerStatus serverStatus;
  final List<dynamic> pedidos;

  const SocketState(this.serverStatus, {this.pedidos = const []});

  SocketState copyWith({List<dynamic>? pedidos}) =>
      SocketState(serverStatus, pedidos: pedidos ?? this.pedidos);

  @override
  List<Object?> get props => [serverStatus, pedidos];
}