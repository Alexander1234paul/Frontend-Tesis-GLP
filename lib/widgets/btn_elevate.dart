import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../bloc/MapClient/map_cliente_bloc.dart';

class BtnElevate extends StatefulWidget {
  const BtnElevate({Key? key}) : super(key: key);

  @override
  State<BtnElevate> createState() => _BtnElevateState();
}

class _BtnElevateState extends State<BtnElevate> {

  @override
  void initState() {
    super.initState();
    // Inicializa la variable mapClienteBloc aquí
    // mapClienteBloc = MapClienteBloc();
  }

  @override
  void dispose() {
    // Asegúrate de liberar los recursos utilizados por el mapClienteBloc cuando el widget se desmonte
    // mapClienteBloc.add(isFalseSlideEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
final mapClientBloc=BlocProvider.of<MapClienteBloc>(context); // Corregido el nombre de la variable

    return Positioned(
      top: 25.0,
      left: 5.0,
      child: ElevatedButton(
        onPressed: () {
          try {
            mapClientBloc.add(isTrueSlideEvent());
          } catch (e) {
            print('Error map client');
            print(e);
            print('Error map client');
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: CircleBorder(),
          primary: Color.fromARGB(
              255, 255, 255, 255), // Cambia este color al color deseado del botón
          onPrimary: Colors.white, // Color del texto del botón
        ),
        child: Icon(
          Icons.menu,
          size: 20.0,
          color: Color(0xFFA72138),
        ),
      ),
    );
  }
}
