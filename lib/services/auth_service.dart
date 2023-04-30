import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/global/environment.dart';
import 'package:frontend_tesis_glp/models/regsiter_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Usuario usuario;
  final String urlMain = Environment.apiUrl;
  late final RegisterResult registerResult;

  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  // bool get autenticando => this._autenticando;
  // set autenticando(bool valor) {
  //   this._autenticando = valor;
  //   notifyListeners();
  // }

//   // Getters del token de forma estática
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  // Future<bool> login(String email, String password) async {
  //   this.autenticando = true;

  //   final data = {'email': email, 'password': password};

  //   final resp = await http.post('${Environment.apiUrl}/login',
  //       body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

  //   this.autenticando = false;

  //   if (resp.statusCode == 200) {
  //     final loginResponse = loginResponseFromJson(resp.body);
  //     this.usuario = loginResponse.usuario;

  //     await this._guardarToken(loginResponse.token);

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future register(String nombre, String email, String password) async {
  //   this.autenticando = true;

  //   final data = {'nombre': nombre, 'email': email, 'password': password};

  //   final resp = await http.post('${Environment.apiUrl}/login/new' as Uri,
  //       body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

  //   this.autenticando = false;

  //   if (resp.statusCode == 200) {
  //     final loginResponse = loginResponseFromJson(resp.body);
  //     this.usuario = loginResponse.usuario;
  //     await this._guardarToken(loginResponse.token);

  //     return true;
  //   } else {
  //     final respBody = jsonDecode(resp.body);
  //     return respBody['msg'];
  //   }
  // }

  Future<RegisterResult> isLoggedIn() async {
    final url = Uri.parse(urlMain + 'renewtoken');
    final String? token = await this._storage.read(key: 'token');
    if (token == null) {
      return registerResult = RegisterResult(statusCode: 500);
    }

    final response = await http.post(url, headers: {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'token': token
    });
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // final loginResponse = loginResponseFromJson(resp.body);
      // this.usuario = loginResponse.usuario;
      await this._guardarToken(responseData['newToken']);
      return registerResult =
          RegisterResult(statusCode: 200, typeUser: responseData['typeUser']);
      ;
    } else {
      // this.logout();
      return responseData['newToken'];
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
