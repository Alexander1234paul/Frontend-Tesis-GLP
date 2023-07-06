import 'package:flutter/material.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Ayuda para el Cliente'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ayuda para el Cliente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Si necesita ayuda o tiene alguna pregunta, puede comunicarse con nuestro equipo de soporte utilizando los siguientes métodos:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Línea de Atención al Cliente'),
              subtitle: const Text('123-456-7890'),
              onTap: () {
                // Acción al presionar la línea de atención al cliente
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Correo Electrónico'),
              subtitle: const Text('soporte@tudistribuidor.com'),
              onTap: () {
                // Acción al presionar el correo electrónico
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat en Vivo'),
              subtitle: const Text('Disponible de lunes a viernes, de 9am a 5pm'),
              onTap: () {
                // Acción al presionar el chat en vivo
              },
            ),
          ],
        ),
      ),
    );
  }
}
