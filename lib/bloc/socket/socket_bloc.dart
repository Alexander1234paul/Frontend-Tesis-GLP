import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../global/environment.dart';
import '../../models/band.dart';
import '../../models/pedido.dart';

part 'socket_event.dart';
part 'socket_state.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final IO.Socket socket;
  final String urlMain = Environment.apiUrl;

  SocketBloc(String token)
      : socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
          // // : socket = IO.io('https://glpapp.fly.dev/', <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
          'forceNew': true,
          'extraHeaders': {'x-token': token}
        }),
        super(SocketState(ServerStatus.Connecting)) {
    on<ConnectEvent>((event, emit) {
      emit(SocketState(ServerStatus.Online));
    });

    on<ConnectionLostEvent>((event, emit) {
      emit(SocketState(ServerStatus.Offline));
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
      print('Error de conexión: $data');
      // Realizar acciones adicionales según sea necesario
    });

    socket.on('lista-pedidos', (payload) {
      // print(payload['pedidos']);

      List<dynamic> jsonData = payload['pedidos'] ?? [];
      add(GetPedidosEvent(jsonData));
    });

    socket.on('pedido-en-proceso', (payload) {
      print(payload);
    });
    socket.connect();
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
