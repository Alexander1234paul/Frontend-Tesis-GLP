import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_tesis_glp/pages/Client/configuraciones.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../global/environment.dart';

class CambioNumeroScreen extends StatefulWidget {
  const CambioNumeroScreen({Key? key}) : super(key: key);

  @override
  _CambioNumeroScreenState createState() => _CambioNumeroScreenState();
}

class _CambioNumeroScreenState extends State<CambioNumeroScreen> {
  final TextEditingController _newNumberController = TextEditingController();
  final _storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    // Obtener el token desde el almacenamiento seguro
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<void> changeNumberCell(String token, String newNumber) async {
    try {
      final String urlMain = Environment.apiUrl;
      final url = Uri.parse(urlMain + 'changeNumberCell');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({'token': token, 'number': newNumber});

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // La solicitud se completó correctamente
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Éxito'),
              content: const Text('Número de teléfono actualizado correctamente'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => InfoDialogScreen(),
                      ),
                    );
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        // La solicitud falló
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Ocurrió un error al actualizar el número de teléfono'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _newNumberController.clear();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Manejo de errores
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Ocurrió un error al actualizar el número de teléfono'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _newNumberController.clear();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showConfirmationDialog(String newNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Estás seguro de que deseas cambiar tu número de teléfono?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final token = await getToken();
                if (token !=null) {
                  await changeNumberCell(token, newNumber);
                } else {
                  // El token no está disponible
                  // Puedes mostrar un diálogo de error o realizar acciones adicionales según sea necesario
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Ocurrió un error al obtener el token'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _newNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Cambio de número'),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(18.0),
              ),
              const SizedBox(height: 18.0),
              const Text(
                'Tu cuenta y todos tus datos se transferirán a tu nuevo número',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                controller: _newNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingrese el nuevo número',
                  labelText: "Número celular",
                  icon: const Icon(Icons.phone_iphone),
                ),
              ),
              const SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: () {
                  final newNumber = _newNumberController.text;
                  if (newNumber.isNotEmpty) {
                    _showConfirmationDialog(newNumber);
                  } else {
                    // El campo del número está vacío
                    // Puedes mostrar un mensaje de error o realizar acciones adicionales según sea necesario
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Por favor, ingrese el nuevo número de teléfono'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 167, 33, 56),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 167, 33, 56),
                    ),
                  ),
                  minimumSize: const Size(300.0, 50.0),
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
