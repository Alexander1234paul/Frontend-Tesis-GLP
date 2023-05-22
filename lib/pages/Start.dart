import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/global/environment.dart';
import 'package:frontend_tesis_glp/pages/Client/home.dart';
import 'package:frontend_tesis_glp/pages/Dealer/home.dart';
import 'package:frontend_tesis_glp/pages/Login/Widgets/form_start.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
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
            MaterialPageRoute(builder: (context) => const HomeDistribuidor()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeClient()));
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
              padding: EdgeInsets.all(responsive.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Cabecera(size: responsive.width),
                  formStart(),
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
      // color: Colors.amber,
      padding: EdgeInsets.symmetric(vertical: widget.size * 0.2),
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
      // color: Colors.amber,

      padding: EdgeInsets.all(size * 0.04),
      child: Text(
        'Al pulsar "Siguiente", acepta los Términos y Condiciones y la Política de Privacidad.',
        style: TextStyle(
          fontSize: size * 0.03,
          color: Color(0xFFA19C9D),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
