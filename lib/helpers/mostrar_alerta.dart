import 'dart:io';

import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  } else {
// No es necesario hacer nada, ya que el código para Cupertino ya está eliminado.
  }
}
