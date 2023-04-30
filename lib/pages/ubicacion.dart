import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/ubication_exacta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

// ignore: camel_case_types
class ubicacion extends StatelessWidget {
  const ubicacion({Key? key}) : super(key: key);
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future<Position> determinarPosicion() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception(
              'La aplicación no tiene permiso para acceder a la ubicación.');
        }
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw Exception('No se pudo determinar la ubicación actual. Error: $e');
    }
  }

  Future<String> getCorruntLocation(BuildContext context) async {
    try {
      final url = Uri.parse('https://app-glp.herokuapp.com/addUbicacion');
      String? token = await getToken();
      Position position = await determinarPosicion();
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'latitud': position.latitude.toString(),
        'longitud': position.longitude.toString(),
        'token': token
      });
      var responseData =
          json.decode(response.body); // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ubicacion_exacta()),
      );
      return '';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(18.0),
                child: const Text(
                  'Habilite el acceso a la ubicación actual para que la aplicación funcione correctamente',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
            const Center(
              child: Image(image: AssetImage('assets/ubica.png')),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
                getCorruntLocation(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25.0), // Radio de borde redondeado de 20.0
                  side: const BorderSide(
                      color: Color.fromARGB(
                          255, 167, 33, 56)), // Borde del botón de color marrón
                ),
                backgroundColor: const Color.fromARGB(
                    255, 167, 33, 56), // Color de fondo marrón
                minimumSize: const Size(300.0, 50.0), // Tamaño mínimo de 200x50
              ),
              child: const Text('Permitir'),
            )
          ],
        ),
      ),
    );
  }
}
