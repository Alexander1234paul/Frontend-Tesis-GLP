import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'socket_event.dart';
part 'socket_state.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final IO.Socket socket;
  final StreamController<String> pedidoEnProcesoController =
      StreamController<String>.broadcast();
  Stream<String> get pedidoEnProcesoStream => pedidoEnProcesoController.stream;

  final StreamController<String> notificacionPedidoController =
      StreamController<String>.broadcast();
  Stream<String> get notificacionPedidoStream =>
      notificacionPedidoController.stream;

  SocketBloc(String token)
      // : socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
          : socket = IO.io('https://glpapp.fly.dev', <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
          'forceNew': true,
          'extraHeaders': {'x-token': token}
        }),
        super(const SocketState(ServerStatus.Connecting)) {
    on<ConnectEvent>((event, emit) {
      emit(const SocketState(ServerStatus.Online));
    });

    on<ConnectionLostEvent>((event, emit) {
      emit(const SocketState(ServerStatus.Offline));
    });

    on<GetPedidosEvent>((event, emit) {
      emit(state.copyWith(pedidos: event.pedidos));
    });

    socket.on('connect', (_) {
      add(ConnectEvent());
    });

    socket.on('disconnect', (_) {
      add(ConnectionLostEvent());
    });

    socket.on('connect_error', (data) {
      // Realizar acciones adicionales según sea necesario
    });
    socket.emit('obtener-pedidos', {});

    socket.on('lista-pedidos', (payload) {
      List<dynamic> jsonData = payload['pedidos'] ?? [];
      add(GetPedidosEvent(jsonData));
    });

    socket.on('pedido-en-proceso', (payload) {
      pedidoEnProcesoController.add(payload.toString());
    });
    socket.on('notificacion-pedido', (payload) {
      notificacionPedidoController.add(payload.toString());
    });
    socket.on('set-location', (payload) {
      print('Escuchando la ubicacion del distribuidor $payload');
    });
    socket.connect();
  }

  @override
  Future<void> close() {
    pedidoEnProcesoController.close();
    notificacionPedidoController.close();

    socket.disconnect();
    socket.dispose();
    return super.close();
  }
}
