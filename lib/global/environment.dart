import 'dart:io';

class Environment {
  static String apiUrl =
      Platform.isAndroid ? 'https://glpapp.fly.dev/' : 'https://glpapp.fly.dev/';
        // Platform.isAndroid ? 'http://10.0.2.2:3000/' : 'http://10.0.2.2:3000/';
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
