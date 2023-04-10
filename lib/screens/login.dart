import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showText = false;
  final _phoneNumberController = TextEditingController();

  Future<String> sendPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('http://10.0.2.2:3000/register_login');
    final response = await http.post(url, body: {'telefono': phoneNumber});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(response);
      _showText = true;
      return responseData['message'];
    } else {
      throw Exception('Failed to send phone number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: const Text(
                'Ingrese su número de teléfono para iniciar sesión',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 150.0),
            Row(
              children: [
                Icon(Icons.flag, color: const Color(0xFF313331)),
                const SizedBox(width: 10),
                Text(
                  '+593',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneNumberController,
                    enableInteractiveSelection: false,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            if (_showText)
              Expanded(
                child: TextField(
                  enableInteractiveSelection: false,
                  autofocus: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Introduzca el código de verificación',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                String message;
                try {
                  _showText = true;
                  message = await sendPhoneNumber(_phoneNumberController.text);
                } catch (e) {
                  message = 'Error sending phone number.';
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: const BorderSide(
                    color: Color(0xFFA72138),
                  ),
                ),
                backgroundColor: const Color(0xFFA72138),
                minimumSize: const Size(300.0, 50.0),
              ),
              child: const Text('Siguiente'),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Al pulsar "Siguiente", acepta los Términos y Condiciones y la Política de Privacidad.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFA19C9D),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _phoneNumberController {}
