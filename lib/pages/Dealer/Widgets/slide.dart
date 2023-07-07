import 'dart:convert';

import 'package:frontend_tesis_glp/pages/Dealer/historial.dart';
import 'package:frontend_tesis_glp/pages/loading.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_tesis_glp/pages/Client/ayuda.dart';
import 'package:frontend_tesis_glp/pages/Client/configuraciones.dart';
import 'package:frontend_tesis_glp/pages/Client/historial_pedidos.dart';
import 'package:frontend_tesis_glp/pages/Client/security_protection.dart';
import 'package:frontend_tesis_glp/pages/Dealer/verificacion.dart';

import '../../../bloc/MapClient/map_cliente_bloc.dart';
import '../../../bloc/dealer/map_dealer_bloc.dart';
import '../../../global/environment.dart';
class SliderDealer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'typeUser': typeUser, 'token': token},
      );
      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const LoadingPage(),
        ));
        return responseData['message'];
      } else {
        return responseData['message'];
      }
    }

    final screenSize = MediaQuery.of(context).size;
    final mapClienteBloc = BlocProvider.of<MapClienteBloc>(context);
    final  mapDealerBloc = BlocProvider.of<MapDealerBloc>(context);


    return Row(
      children: [
        Container(
          width: 290,
          height: screenSize.height,
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'DISTRIBUIDOR',
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 84, 12, 12),
                  ),
                ),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/usuario.png',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 248, 248),
                  //image: DecorationImage(
                  //   fit: BoxFit.fill,
                  // image: NetworkImage(
                  //    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.house),
                title: const Text(
                  'Principal',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyApp()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  'Mis pedidos',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HistoryOrderDealer(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  'Configuraciones',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => InfoDialogScreen(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text(
                  'Seguridad y Protección',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SeguridadProteccionScreen(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text(
                  'Ayuda',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AyudaScreen(),
                  ));
                },
              ),
              const Divider(),
              const SizedBox(
                height: 60.0,
              ),
              OutlinedButton(
                onPressed: () {
                  String message;
                  message = addTypeUser(context, 'Usuario') as String;
                },
                style: OutlinedButton.styleFrom(
                  primary: const Color.fromARGB(255, 78, 14, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 93, 13, 27),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 246, 242, 243),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Cambiar modo clien fdfste'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Se hizo clic en el segundo conteasdadsnedor');
                        mapDealerBloc.add(stateFalseDealer());

            },
            child: Container(
              width: 100,
              height: screenSize.height,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu-img.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
