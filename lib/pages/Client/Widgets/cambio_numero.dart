import 'package:flutter/material.dart';

class CambioNumeroScreen extends StatelessWidget {
  const CambioNumeroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA72138),
        title: const Text('Cambio de número'),
        elevation: 10,
      ),
      body: Container(
        // padding: const EdgeInsets.all(30.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
            ),
            Center(
              child: Transform.scale(
                scale: 0.5,
                //child: Image.asset('assets/images/seguridad.png'),
              ),
            ),
            Text(
              'Tu cuenta y todos tus datos se transferiran a tu nuevo número',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Escribe el precio de compra';
              //   }
              //   return null;
              // },
              //controller: _precioCompra,
              decoration: InputDecoration(
                  hintText: 'Ingrese el nuevo número',
                  labelText: "Numero celular",
                  icon: Icon(Icons.phone_iphone)),
            ),
            const SizedBox(
              height: 500.0,
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // final email = _emailController.text;
                // addEmail(context, email);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
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
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
