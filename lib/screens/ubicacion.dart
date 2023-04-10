import 'package:flutter/material.dart';

// ignore: camel_case_types
class ubicacion extends StatelessWidget {
  const ubicacion({super.key});

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
                // alignment: Alignment.center,

                padding: const EdgeInsets.all(18.0),
                child: const Text(
                  'Habilite el acceso a la ubicación actual para que la aplicación funcione correctamente',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
            const Center(
              child: Image(image: AssetImage('assets/ubica.png')),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white, // Color del texto
                shape: RoundedRectangleBorder(
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
