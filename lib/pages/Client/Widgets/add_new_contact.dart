import 'package:flutter/material.dart';

class AddNewContactScreen extends StatelessWidget {
  const AddNewContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Agregar Nuevo Contacto'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agregar Nuevo Contacto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre',
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Ingrese el número de teléfono',
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                hintText: 'Ingrese el correo electrónico',
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de Agregar
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFA72138),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                minimumSize: const Size(200.0, 50.0),
              ),
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
