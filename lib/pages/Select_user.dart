import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/reg_names.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../global/environment.dart';

// ignore: camel_case_types
class select_user extends StatelessWidget {
  const select_user({super.key});
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  Future<String> addTypeUser(BuildContext context, String typeUser) async {
    final String urlMain = Environment.apiUrl;
      final url = Uri.parse(urlMain + 'addTypeUser');
    // final url = Uri.parse('https://app-glp.herokuapp.com/addTypeUser');

    String? token = await getToken();
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'typeUser': typeUser, 'token': token});
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously

      Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: RegNames(),
              )),
    );
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const RegNames()));

      return responseData['message'];
    } else {
      return responseData['message'];
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
                  '¿Usted es usuario o distribuidor?',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                '¿Usted es usuario o distribuidor?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Transform.scale(
                scale:
                    0.7, // Establecer la escala a 0.5 para reducir a la mitad
                child: const Image(image: AssetImage('assets/familia.jpg')),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
                String message;
                try {
                  message = addTypeUser(context, 'Usuario') as String;
                  print(message);
                } catch (e) {
                  print(e);
                }
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
              child: const Text('Usuario'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
                String message;
                try {
                  message = addTypeUser(context, 'Distribuidor') as String;
                  print(message);
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 160, 28, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25.0), // Radio de borde redondeado de 20.0
                  side: const BorderSide(
                      color: Color.fromARGB(
                          255, 170, 30, 30)), // Borde del botón de color marrón
                ),
                backgroundColor: const Color.fromARGB(
                    255, 255, 255, 255), // Color de fondo marrón
                minimumSize: const Size(70.0, 70.0), // Tamaño mínimo de 70x70
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart,
                      color: Colors.black, size: 20.0), // Icono de carrito
                  SizedBox(width: 5), // Separador entre el icono y el texto
                  Text(
                    'Distribuidor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0, // Tamaño de fuente reducido
                    ), // Texto en negrita
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
