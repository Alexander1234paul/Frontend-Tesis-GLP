import 'package:flutter/material.dart';

class TerminosCondicionesScreen extends StatelessWidget {
  const TerminosCondicionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Términos y Condiciones'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'Términos y Condiciones',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Al utilizar esta aplicación, usted acepta los siguientes términos y condiciones:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '1. Uso de la Aplicación: La aplicación se utiliza para solicitar y gestionar la distribución de gas doméstico. El usuario es responsable de proporcionar información precisa y utilizar la aplicación de acuerdo con las regulaciones y políticas vigentes.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '2. Responsabilidad del Usuario: El usuario es responsable de mantener la confidencialidad de su cuenta y de todas las actividades que se realicen a través de ella. Cualquier uso no autorizado de la cuenta es responsabilidad exclusiva del usuario.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '3. Privacidad: Los datos personales proporcionados por el usuario serán utilizados únicamente con fines de la distribución de gas doméstico y se regirán por nuestra política de privacidad.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '4. Modificaciones: Nos reservamos el derecho de realizar cambios en los términos y condiciones sin previo aviso. Es responsabilidad del usuario revisar periódicamente los términos y condiciones actualizados.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '5. Contacto: Si tiene alguna pregunta o inquietud sobre los términos y condiciones, puede ponerse en contacto con nuestro equipo de soporte.',
              style: TextStyle(fontSize: 16),
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
 