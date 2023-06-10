import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../bloc/socket/socket_bloc.dart';

class HomeDistribuidor extends StatefulWidget {
  const HomeDistribuidor({Key? key}) : super(key: key);

  @override
  State<HomeDistribuidor> createState() => _HomeDistribuidorState();
}

// Pantalla principal del distribuidor
class _HomeDistribuidorState extends State<HomeDistribuidor> {
  bool isLeftSelected = true; // Variable para controlar la selección izquierda/derecha
  late SocketBloc _socketBloc; // Instancia del bloque de sockets
  bool _showPopup = false; // Variable para mostrar/ocultar ventana emergente
  int _countdown = 10; // Contador para la cuenta regresiva
  late Timer _timer; // Temporizador para la cuenta regresiva

  @override
  void initState() {
    super.initState();
    _socketBloc = BlocProvider.of<SocketBloc>(context); // Obtener el bloque de sockets del contexto
    _socketBloc.add(ConnectEvent()); // Iniciar la conexión con el servidor de sockets
    _startCountdownTimer(); // Iniciar el temporizador de cuenta regresiva
  }

  // Método para alternar la selección izquierda/derecha
  void toggleSelection() {
    setState(() {
      isLeftSelected = !isLeftSelected;
    });
  }

  // Método para iniciar el temporizador de cuenta regresiva
  void _startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
        _closePopup();
      }
    });
  }

  // Método para mostrar una ventana emergente con los detalles de un registro
  void _showPopupWindow(dynamic registro) {
    _showPopup = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Detalle del último registro'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${registro['Cliente']['nombre']}'),
                Text('Fecha: ${registro['Cliente']['fecha']}'),
                Text('Cilindros: ${registro['Cliente']['numCilindro']}'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: _acceptOrder,
                child: Text('Aceptar'),
              ),
              ElevatedButton(
                onPressed: _rejectOrder,
                child: Text('Rechazar'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para cerrar la ventana emergente
  void _closePopup() {
    setState(() {
      _showPopup = false;
    });
    Navigator.of(context).pop();
  }

  // Método para aceptar un pedido
  void _acceptOrder() {
    // Lógica para aceptar el pedido
    _closePopup();
  }

  // Método para rechazar un pedido
  void _rejectOrder() {
    // Lógica para rechazar el pedido
    _closePopup();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el temporizador cuando el widget se elimina
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketBloc, SocketState>(
      listener: (context, state) {
        if (state.pedidos.isNotEmpty) {
          _showPopupWindow(state.pedidos.last); // Mostrar la ventana emergente con el último pedido
        }
      },
      child: Scaffold(
        appBar: appBar(), // Construir la barra de aplicaciones
        body: BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            final List<dynamic> pedidos = state.pedidos ?? [];
            return ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text(pedidos[index]['estado'].substring(0, 2)),
                  backgroundColor: Colors.blue[100],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${pedidos[index]['Cliente']['nombre']}'),
                    Text('Fecha: ${pedidos[index]['Cliente']['fecha']}'),
                    Text(
                        'Cilindros: ${pedidos[index]['Cliente']['numCilindro']}'),
                  ],
                ),
                trailing: Text(
                  '${pedidos[index]['estado']}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottonBar(), // Barra de navegación inferior
      ),
    );
  }

  // Construir la barra de aplicaciones personalizada
  AppBar appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 188, 185, 179),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Acción al presionar el botón de menú (izquierda)
        },
      ),
      centerTitle: true,
      title: Container(
        height: 23,
        width: 195,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: toggleSelection, // Alternar la selección izquierda/derecha al hacer clic
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isLeftSelected ? 0 : 75,
                right: isLeftSelected ? 75 : 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: isLeftSelected
                        ? Colors.red
                        : Color.fromARGB(255, 105, 211, 109),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      isLeftSelected ? 'No disponible' : 'Disponible',
                      style: TextStyle(
                        color: isLeftSelected ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Barra de navegación inferior
class BottonBar extends StatelessWidget {
  const BottonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.support),
          label: 'Soporte',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: 0, // Índice del botón seleccionado actualmente
      onTap: (index) {
        // Acción al hacer clic en un botón del bottomNavigationBar
        print('Button $index tapped');
      },
    );
  }
}
