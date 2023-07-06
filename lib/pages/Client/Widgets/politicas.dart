import 'package:flutter/material.dart';

class PoliticasScreen extends StatelessWidget {
  const PoliticasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA72138),
        title: const Text('Políticas'),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'Políticas de Privacidad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'En nuestra aplicación, nos comprometemos a proteger su privacidad y garantizar la seguridad de la información personal que nos proporciona. A continuación, se detallan nuestras políticas de privacidad:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '1. Recopilación de Datos: Recolectamos y almacenamos la información personal que usted proporciona al registrarse en nuestra aplicación, como su nombre, dirección y número de teléfono. Esta información se utiliza exclusivamente para brindarle un servicio personalizado y mejorar su experiencia.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '2. Uso de la Información: La información personal recopilada se utiliza para procesar sus solicitudes de distribución de gas doméstico, enviar notificaciones relevantes y mantener una comunicación efectiva con usted. No compartiremos su información con terceros sin su consentimiento.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '3. Seguridad de los Datos: Implementamos medidas de seguridad para proteger su información personal contra accesos no autorizados, modificaciones o divulgaciones. Solo el personal autorizado tiene acceso a esta información.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '4. Derechos del Usuario: Usted tiene el derecho de acceder, corregir o eliminar su información personal. Si desea ejercer estos derechos, puede comunicarse con nuestro equipo de soporte.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '5. Modificaciones: Nos reservamos el derecho de realizar cambios en nuestras políticas de privacidad sin previo aviso. Se recomienda revisar periódicamente las políticas actualizadas.',
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
