part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final ServerStatus serverStatus; // Estado del servidor de sockets
  final List<dynamic> pedidos; // Lista de pedidos

  const SocketState(this.serverStatus, {this.pedidos = const []});

  // Método que crea una copia del estado con valores actualizados
  SocketState copyWith({List<dynamic>? pedidos}) =>
      SocketState(serverStatus, pedidos: pedidos ?? this.pedidos);

  @override
  List<Object?> get props => [serverStatus, pedidos]; // Propiedades utilizadas para comparaciones de igualdad
}