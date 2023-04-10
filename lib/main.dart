import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/routes/routes.dart';
import 'package:frontend_tesis_glp/screens/contactos.dart';
import 'package:frontend_tesis_glp/screens/screens.dart';
import 'package:frontend_tesis_glp/screens/ubicacion.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
    
    );
  }
}
