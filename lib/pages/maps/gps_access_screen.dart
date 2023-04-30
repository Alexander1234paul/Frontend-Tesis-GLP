import 'package:flutter/material.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AccessBotton(),
      ),
    );
  }
}

class _AccessBotton extends StatelessWidget {
  const _AccessBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso a GPS'),
        MaterialButton(
            child: const Text(
              'Solicitar Acceso',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {})
      ],
    );
  }
}

class EnableGPSMessagge extends StatelessWidget {
  const EnableGPSMessagge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe habilitar el GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
