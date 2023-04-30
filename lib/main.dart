import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/routes/routes.dart';
import 'package:flutter/services.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'sans'),
      title: 'Material App',
      initialRoute: 'gps-access',
      routes: appRoutes,
    );
  }
}
