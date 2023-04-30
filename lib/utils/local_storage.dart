import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class localStorage {
  final _storage = const FlutterSecureStorage();

  Future guardarToken(String token) async {
    print('Token guardando... '+token);
    return await _storage.write(key: 'token', value: token);
  }
   Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }
}
