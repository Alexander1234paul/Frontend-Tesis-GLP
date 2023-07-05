import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/acerca_app.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/cambio_numero.dart';


class InfoDialogScreen extends StatefulWidget {
  const InfoDialogScreen({Key? key}) : super(key: key);
  @override
  _InfoDialogScreen createState() => _InfoDialogScreen();
}

class _InfoDialogScreen extends State<InfoDialogScreen> {
  bool valNotifi1 = false;
  onChangeMethod(bool newValue) {
    setState(() {
      valNotifi1 = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                          Text('¿Está seguro de cambiar su número de celular?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const CambioNumeroScreen()));
                          },
                          child: Text('ACEPTAR'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            cambioModoOscuro('Cambio modo oscuro', valNotifi1, onChangeMethod),
            ListTile(
              title: Text('Acerca de la aplicación'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const AcercaAppScreen()));
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

//Esta clase sirve para crear un boton de switch
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
              // fontWeight: FontWeight.w500,
              // color: Colors.grey[600],
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
