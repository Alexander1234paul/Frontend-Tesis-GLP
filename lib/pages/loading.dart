import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/models/regsiter_response.dart';
import 'package:frontend_tesis_glp/pages/Login/Widgets/respaldo.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
import 'package:frontend_tesis_glp/pages/distribuidor.dart';
import 'package:frontend_tesis_glp/services/auth_service.dart';
import 'package:http/http.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }
}

Future<void> checkLoginState(BuildContext context) async {
  final auth = AuthService();
  final RegisterResult registerResult = await auth.isLoggedIn();
  print(registerResult.typeUser);
  if (registerResult.statusCode == 200) {
    if (registerResult.typeUser == 'Distribuidor') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DistribuidorPage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ClientePage()));
    }

    // El usuario ya ha iniciado sesión, realiza alguna acción aquí
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    // El usuario no ha iniciado sesión, realiza alguna acción aquí
  }
}
