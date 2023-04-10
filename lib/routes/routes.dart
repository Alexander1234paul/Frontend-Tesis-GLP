import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/screens/loading.dart';
import 'package:frontend_tesis_glp/screens/login.dart';
import 'package:frontend_tesis_glp/screens/ubicacion.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => const LoginScreen(),
  'ubication': (_) => const ubicacion(),
  'loading': (_) => const LoadingPage()
};
