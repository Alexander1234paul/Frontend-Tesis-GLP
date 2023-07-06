import 'package:flutter/material.dart';

class VersionAppScreen extends StatelessWidget {
  const VersionAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Versión de la Aplicación'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Versión de la Aplicación',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Versión actual: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '¡Gracias por utilizar nuestra aplicación de distribución de gas doméstico!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de Actualizar
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFA72138),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: const Size(200.0, 50.0),
              ),
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
