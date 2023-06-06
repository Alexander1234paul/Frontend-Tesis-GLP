import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  SocketBloc()
      // : socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
              : socket = IO.io('https://glpapp.fly.dev/', <String, dynamic>{

          'transports': ['websocket'],
          'autoConnect': true,
        }),
        super(SocketState(ServerStatus.Connecting)) {
    on<ConnectEvent>((event, emit) {
      emit(SocketState(ServerStatus.Online));
    });

    on<ConnectionLostEvent>((event, emit) {
      emit(SocketState(ServerStatus.Offline));
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
      print(payload['pedidos']);

       List<dynamic> jsonData = payload['pedidos'] ?? [];// Accede a 'pedidos' en el mapa 'payload'
       // Decodifica el primer elemento de 'jsonData'
      // print(jsonData);
      add(getPedidos(
          jsonData)); // Pasa 'jsonData' como argumento en lugar de 'pedidos'
    });

    socket.connect();
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
