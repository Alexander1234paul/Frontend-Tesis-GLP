import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/global/environment.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
import 'package:frontend_tesis_glp/pages/distribuidor.dart';
import 'package:frontend_tesis_glp/pages/ubicacion.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:frontend_tesis_glp/widgets/input_text_login.dart';
import 'package:frontend_tesis_glp/widgets/roudend_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final urlx = Environment.apiUrl;
  bool _showText = false;
  final _phoneNumberController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future sendPhoneNumber(String phoneNumber) async {
    try {
      final url = Uri.parse(urlx + 'register_login');
      final response = await http.post(url, body: {'telefono': phoneNumber});

      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _showText = true;
        });
        return responseData['message'];
      } else {
        return responseData['message'];
      }
    } catch (e) {
      return e;
    }
  }

  Future<String> sendCode(String code) async {
    final url = Uri.parse(urlx + 'verificarCodigo');
    final response = await http.post(url, body: {'codigoVerificacion': code});
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _showText = true;
      });

      if (responseData['typeUser'] == 'Distribuidor') {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DistribuidorPage()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ClientePage()));
      }

      _guardarToken(responseData['token']);
      return responseData['message'];
    } else if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ubicacion()));
      _guardarToken(responseData['token']);
      return responseData['message'];
    } else {
      return responseData['message'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Cabecera(size: responsive.width),
                  const SizedBox(height: 150.0),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flag, color: Color(0xFF313331)),
                          SizedBox(width: 10),
                          Text(
                            '+593',
                            style: TextStyle(fontSize: 24),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneNumberController,
                              enableInteractiveSelection: false,
                              autofocus: true,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // InputText(placeholder: 'asas')

                      if (_showText)
                        Expanded(
                          child: TextField(
                            enableInteractiveSelection: false,
                            autofocus: true,
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              hintText: 'Introduzca el código de verificación',
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 6) {
                                sendCode(value);
                                // Realizar la acción que desee aquí, como enviar el código de verificación a su servidor o verificar si es correcto.
                              }
                            },
                          ),
                        ),
                      const SizedBox(height: 10.0),
                      // RoundedButton(
                      //   onPressed: () {},
                      //   label: 'Siguiente',
                      //   backgroundColor: Color(0xFFA72138),
                      // ),
                      ElevatedButton(
                        onPressed: () async {
                          String message;
                          try {
                            message = await sendPhoneNumber(
                                _phoneNumberController.text);
                          } catch (e) {
                            message = 'Error sending phone number.';
                          }
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
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
                    ],
                  ),
                  TerminosCondiciones(
                    size: responsive.width,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Cabecera extends StatefulWidget {
  final double size;
  const Cabecera({super.key, required this.size})
      : assert(size != null && size > 0);

  @override
  State<Cabecera> createState() => _CabeceraState();
}

class _CabeceraState extends State<Cabecera> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        'Ingrese su número de teléfono para iniciar sesión',
        style: TextStyle(fontSize: widget.size * 0.06),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TerminosCondiciones extends StatelessWidget {
  final double size;
  const TerminosCondiciones({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.02),
      child: Text(
        'Al pulsar "Siguiente", acepta los Términos y Condiciones y la Política de Privacidad.',
        style: TextStyle(
          fontSize: size * 0.02,
          color: Color(0xFFA19C9D),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
