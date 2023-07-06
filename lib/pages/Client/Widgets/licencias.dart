import 'package:flutter/material.dart';

class LicenciasScreen extends StatelessWidget {
  const LicenciasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Licencias'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'Licencias de Software',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Esta aplicación utiliza software de código abierto con las siguientes licencias:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                'Licencia A',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Descripción de la Licencia A',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              title: Text(
                'Licencia B',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Descripción de la Licencia B',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ListTile(
              title: Text(
                'Licencia C',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Descripción de la Licencia C',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de Aceptar
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFA72138),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: const Size(200.0, 50.0),
              ),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
