
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
import 'package:frontend_tesis_glp/pages/distribuidor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class RegEmail extends StatefulWidget {
  const RegEmail({Key? key}) : super(key: key);

  @override
  _RegEmailState createState() => _RegEmailState();
}

class _RegEmailState extends State<RegEmail> {
  final _emailController = TextEditingController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future<String> addEmail(BuildContext context, String email) async {
    final url = Uri.parse('https://app-glp.herokuapp.com/addEmail');

    String? token = await getToken();
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'email': email, 'token': token});
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ClientePage()));

      return responseData['message'];
    } else if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DistribuidorPage()));

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
            GestureDetector(
              onTap: () {
                // Acción a realizar cuando se hace clic en el texto "Omitir >"
                addEmail(context, '');
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  'Omitir >',
                  style: TextStyle(
                    color: Colors.green, // Color verde
                    fontSize: 24.0, // Tamaño de fuente más grande
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(01.0),
              child: const Text(
                '!Hola, usuario!',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                '¿Cuál es su correo electrónico?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Agregar negrita
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    enableInteractiveSelection: false,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                final email = _emailController.text;
                addEmail(context, email);
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
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
