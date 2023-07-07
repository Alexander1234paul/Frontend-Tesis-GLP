import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/acerca_app.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/cambio_numero.dart';
import 'package:frontend_tesis_glp/pages/Start.dart';

import '../../services/auth_service.dart';

class InfoDialogScreen extends StatefulWidget {
  const InfoDialogScreen({Key? key}) : super(key: key);

  @override
  _InfoDialogScreenState createState() => _InfoDialogScreenState();
}

class _InfoDialogScreenState extends State<InfoDialogScreen> {
  bool valNotifi1 = false;
  final auth = AuthService();
  void onChangeMethod(bool newValue) {
    setState(() {
      valNotifi1 = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA72138),
        title: const Text('Configuraciones'),
        elevation: 10,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Cambiar número'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const CambioNumeroScreen(),
                  ),
                );
                if (result == 'completed') {
                  // Se completó el cambio de número, realizar acciones adicionales si es necesario
                }
              },
            ),
            cambioModoOscuro('Cambio modo oscuro', valNotifi1, onChangeMethod),
            ListTile(
              title: Text('Acerca de la aplicación'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const AcercaAppScreen(),
                  ),
                );
              },
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            ListTile(
              title: Text('Cerrar sesión'),
              trailing: Icon(Icons.logout),
              iconColor: Colors.blue,
              onTap: () {
                auth.deleteToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                            child: LoginScreen(),
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding cambioModoOscuro(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
