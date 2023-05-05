import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
import 'package:frontend_tesis_glp/pages/distribuidor.dart';
import 'package:frontend_tesis_glp/pages/reg_email.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../global/environment.dart';

class RegNames extends StatefulWidget {
  const RegNames({Key? key}) : super(key: key);

  @override
  _RegNamesState createState() => _RegNamesState();
}

class _RegNamesState extends State<RegNames> {
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future<String> addNames(
      BuildContext context, String nombre, String apellido) async {
        final String urlMain = Environment.apiUrl;
      final url = Uri.parse(urlMain + 'addnames');
    // final url = Uri.parse('https://app-glp.herokuapp.com/addnames');

    String? token = await getToken();
    String? nombres = '$nombre $apellido';
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'nombres': nombres, 'token': token});
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const RegEmail()));

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
              padding: const EdgeInsets.all(01.0),
              child: const Text(
                '!Bienvenidos a Gas Delivery¡',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                'Conozcámonos',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nombre,
                    enableInteractiveSelection: false,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Nombre',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _apellido,
                    enableInteractiveSelection: false,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Apellido',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                addNames(context, _nombre.text, _apellido.text);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25.0), // Radio de borde redondeado de 20.0
                  side:
                      const BorderSide(color: Color.fromARGB(255, 167, 33, 56)),
// Borde del botón de color marrón
                ),
                backgroundColor: const Color.fromARGB(
                    255, 167, 33, 56), // Color de fondo marrón
                minimumSize: const Size(300.0, 50.0), // Tamaño mínimo de 200x50
              ),
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
