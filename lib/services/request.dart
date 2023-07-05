import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/global/environment.dart';
import 'package:frontend_tesis_glp/models/regsiter_response.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/places_models.dart';
import 'auth_service.dart';

class RequestHttp {
  final String urlMain = Environment.apiUrl;
  final AuthService authService = AuthService();

  Future<RegisterResult> register(String phoneNumber) async {
    try {
      final url = Uri.parse(urlMain + 'register_login');
      final response = await http.post(url, body: {'telefono': phoneNumber});

      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return RegisterResult(
            message: responseData['message'], statusCode: 200);
      } else if (response.statusCode == 201) {
        return RegisterResult(
            message: responseData['message'], statusCode: 201);
      } else {
        return RegisterResult(
            message: responseData['message'], statusCode: 500);
      }
    } catch (e) {
      return RegisterResult(message: 'Error al registrar: $e', statusCode: 500);
    }
  }

  Future<RegisterResult> verifyCode(String code) async {
    try {
      final url = Uri.parse(urlMain + 'verificarCodigo');
      final response = await http.post(url, body: {'codigoVerificacion': code});

      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return RegisterResult(
            message: responseData['message'],
            statusCode: 200,
            typeUser: responseData['typeUser'],
            token: responseData['token']);
      } else if (response.statusCode == 201) {
        return RegisterResult(
            message: responseData['message'],
            statusCode: 201,
            typeUser: responseData['typeUser'],
            token: responseData['token']);
      } else {
        return RegisterResult(
            message: responseData['message'],
            statusCode: 500,
            typeUser: responseData['typeUser'],
            token: responseData['token']);
      }
    } catch (e) {
      return RegisterResult(
          message: 'Error al registrar: $e',
          statusCode: 500,
          typeUser: 'typeUser');
    }
  }

  Future newOrderCliente(
    String numCilindros,
    String latitud,
    String longitud,
  ) async {
    try {
      // final url = Uri.parse(urlMain + 'newOrderClient');
      String? token = await authService.getToken();
      // final response = await http.post(url, body: {
      //   'token': token,
      //   'latitud': latitud,
      //   'longitud': longitud,
      //   'numCilindro': numCilindros
      // });
      // print(numCilindros);
      // print(longitud);
      // print(latitud);
      // print(numCilindros);

      // final socketBloc = BlocProvider.of<SocketBloc>(context as BuildContext);

      // socketBloc.socket.emit('nuevo-pedido', {
      //   'token': token,
      //   'latitud': latitud,
      //   'longitud': longitud,
      //   'numCilindro': numCilindros
      // });

      // final response = await http.post(url, body: {'codigoVerificacion': code});

      // var responseData = json.decode(response.body);

      // if (response.statusCode == 200) {
      //   return RegisterResult(
      //       message: responseData['message'],
      //       statusCode: 200,
      //       typeUser: responseData['typeUser'],
      //       token: responseData['token']);
      // } else if (response.statusCode == 201) {
      //   return RegisterResult(
      //       message: responseData['message'],
      //       statusCode: 201,
      //       typeUser: responseData['typeUser'],
      //       token: responseData['token']);
      // } else {
      //   return RegisterResult(
      //       message: responseData['message'],
      //       statusCode: 500,
      //       typeUser: responseData['typeUser'],
      //       token: responseData['token']);
      // }
    } catch (e) {
      // return RegisterResult(
      //     message: 'Error al registrar: $e',
      //     statusCode: 500,
      //     typeUser: 'typeUser');
    }
  }
}
