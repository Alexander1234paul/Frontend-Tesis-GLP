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

class _HomeDistribuidorState extends State<HomeDistribuidor> {
  bool isLeftSelected = true;

  void toggleSelection() {
    setState(() {
      isLeftSelected = !isLeftSelected;
    });
  }

  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   final response =
  //       await http.get(Uri.parse('https://glpapp.fly.dev/getOrderPendientes'));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       dataList = data['result'];
  //     });
  //   } else {
  //     // Manejar el caso de error al obtener los datos de la API
  //     print('Error al obtener los datos de la API');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        final List<dynamic> pedidos = state.pedidos ?? [];
        return Scaffold(
          appBar: appBar(),
          body: ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text(pedidos[index]['estado'].substring(0, 2)),
                backgroundColor: Colors.blue[100],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha: ${pedidos[index]['Cliente']['fecha']}'),
                  Text(
                      'Num. Cilindro: ${pedidos[index]['Cliente']['numCilindro']}'),
                ],
              ),
              trailing: Text(
                '${pedidos[index]['estado']}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          bottomNavigationBar: BottonBar(),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: appBar(),
  //     body: const Text('data'),
  //   bottomNavigationBar: BottonBar(),

  //   );
  // }

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
          onTap: toggleSelection,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isLeftSelected ? 0 : 75,
                right: isLeftSelected ? 75 : 0,
                child: Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 1),
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

class BottonBar extends StatelessWidget {
  const BottonBar({
    super.key,
  });

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
