import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/reg_email.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../global/environment.dart';

class RegNames extends StatefulWidget {
  const RegNames({Key? key}) : super(key: key);

  @override
  _RegNamesState createState() => _RegNamesState();
}

class _RegNamesState extends State<RegNames> {
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future<String> addNames(
      BuildContext context, String nombre, String apellido) async {
        final String urlMain = Environment.apiUrl;
      final url = Uri.parse(urlMain + 'addnames');
    // final url = Uri.parse('https://app-glp.herokuapp.com/addnames');

    String? token = await getToken();
    String? nombres = '$nombre $apellido';
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'nombres': nombres, 'token': token});
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: RegEmail(),
              )),
    );

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const RegEmail()));

      return responseData['message'];
    } else {
      return responseData['message'];
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                '!Bienvenidos a Gas Delivery¡',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                'Conozcámonos',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _nombre,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Nombre',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _apellido,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Apellido',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                addNames(context, _nombre.text, _apellido.text);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 167, 33, 56),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: Size(300.0, 50.0),
              ),
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    ),
  );
}
}