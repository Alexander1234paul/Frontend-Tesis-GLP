import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/licencias.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/politicas.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/terminos_condiciones.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/version.dart';

//import '../NavBar.dart';

class AcercaAppScreen extends StatelessWidget {
  const AcercaAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFA72138),
        title: const Text('Acerca de la aplicación'),
        elevation: 10,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Terminos y condiciones'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const TerminosCondicionesScreen()));
            },
          ),
          ListTile(
            title: Text('Politica de privacidad'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const PoliticasScreen()));
            },
          ),
          ListTile(
            title: Text('Licencias'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const LicenciasScreen()));
            },
          ),
          ListTile(
            title: Text('Version de la aplicacion'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const VersionAppScreen()));
            },
          )
        ],
      ),
    );
  }
}
