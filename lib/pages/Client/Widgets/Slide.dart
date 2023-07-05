import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/pages/Client/ayuda.dart';
import 'package:frontend_tesis_glp/pages/Client/configuraciones.dart';
import 'package:frontend_tesis_glp/pages/Client/historial_pedidos.dart';
import 'package:frontend_tesis_glp/pages/Client/security_protection.dart';
import 'package:frontend_tesis_glp/pages/Dealer/verificacion.dart';

import '../../../bloc/MapClient/map_cliente_bloc.dart';

class Slide extends StatelessWidget {
  const Slide({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mapClienteBloc = BlocProvider.of<MapClienteBloc>(context);

    return Row(
      children: [
        Container(
          width: 290,
          height: screenSize.height,
          color: Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('DIEGO',
                    style: const TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 84, 12, 12))),
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
                  color: Color.fromARGB(255, 249, 248, 248),
                  //image: DecorationImage(
                  //   fit: BoxFit.fill,
                  // image: NetworkImage(
                  //    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              ),
              // DESDE AQUI EMPIEZA EL LSITADO DE LOS ICONOS
              ListTile(
                leading: Icon(Icons.house),
                title: Text(
                  'Principal',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyApp()));
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  'Mis pedidos',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HistoryOrderClient()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Configuraciones',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => InfoDialogScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text(
                  'Seguridad y Protección',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SeguridadProteccionScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  'Ayuda',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AyudaScreen()));
                },
              ),
              Divider(),
              const SizedBox(
                height: 60.0,
              ),

              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const VerificacionDatosScreen()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 78, 14, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Radio de borde redondeado de 20.0
                    side: const BorderSide(
                        color: Color.fromARGB(255, 93, 13,
                            27)), // Borde del botón de color marrón
                  ),
                  backgroundColor: Color.fromARGB(255, 246, 242, 243),
                  minimumSize: Size(double.infinity, 50),
                  // Color de fondo marrón
                  // Tamaño mínimo de 200x50
                ),
                child: const Text('Cambiar modo distribuidor'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Se hizo clic en el segundo contenedor');
              mapClienteBloc.add(isFalseSlideEvent());
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
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
    );
  }
}
