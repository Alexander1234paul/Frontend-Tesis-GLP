import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BtnElevate extends StatefulWidget {
  const BtnElevate({super.key});

  @override
  State<BtnElevate> createState() => _BtnElevateState();
}

class _BtnElevateState extends State<BtnElevate> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25.0,
  left: 5.0,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: CircleBorder(),
          primary: Color.fromARGB(
              255, 255, 255, 255), // Cambia este color al color deseado del botón
          onPrimary: Colors.white, // Color del texto del botón
        ),
        child: Icon(
          Icons.menu,
          size: 20.0,
          color: Color(0xFFA72138),
        ),
      ),
    );
  }
}
