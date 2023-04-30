import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/pages/Select_user.dart';
import 'package:frontend_tesis_glp/pages/loading.dart';
import 'package:frontend_tesis_glp/pages/Start.dart';
import 'package:frontend_tesis_glp/pages/reg_email.dart';
import 'package:frontend_tesis_glp/pages/reg_foto.dart';
import 'package:frontend_tesis_glp/pages/reg_names.dart';
import 'package:frontend_tesis_glp/pages/ubicacion.dart';
import 'package:frontend_tesis_glp/pages/ubication_exacta.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => const LoginScreen(),
  'ubication': (_) => const ubicacion(),
  'loading': (_) => const LoadingPage(),
  'ubication_exacta': (_) => const ubicacion_exacta(),
  'select_user': (_) => const select_user(),
  'reg_names': (_) => const RegNames(),
  'reg_email': (_) => const RegEmail(),
  'reg_foto': (_) => const RegFoto()
};
