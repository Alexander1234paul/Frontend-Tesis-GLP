import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/add_new_contact.dart';


class SeguridadProteccionScreen extends StatelessWidget {
  const SeguridadProteccionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA72138),
        title: Text('Seguridad y protección'),
      ),
      //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        // padding: const EdgeInsets.all(30.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
            ),
            Center(
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/seguridad.png'),
              ),
            ),
            const Text(
              '¿Con quién desea ponerse en contacto?',
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Agregar mi propio contacto'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewContactScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Ambulancia'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewContactScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Policia'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewContactScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Consejos de seguridad'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewContactScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
