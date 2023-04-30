import 'package:flutter/material.dart';

// ignore: camel_case_types
class RegFoto extends StatelessWidget {
  const RegFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(18.0),
                child: const Text(
                  'Agregue su foto',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
            Center(
              child: Transform.scale(
                scale:
                    0.5, // Establecer la escala a 0.5 para reducir a la mitad
                child: const  Image(image:  AssetImage('assets/usuario.png')),
              ),
            ),
            const Text(
              'Añadir foto',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25.0), // Radio de borde redondeado de 20.0
                  side: const BorderSide(
                      color: Color.fromARGB(
                          255, 167, 33, 56)), // Borde del botón de color marrón
                ),
                backgroundColor: const Color.fromARGB(
                    255, 167, 33, 56), // Color de fondo marrón
                minimumSize: const Size(300.0, 50.0), // Tamaño mínimo de 200x50
              ),
              child: const Text('Siguiente'),
            )
          ],
        ),
      ),
    );
  }
}
