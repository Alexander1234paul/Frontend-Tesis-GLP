import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1IjoiYWxleGFuZGVycXVpbmF0b2EiLCJhIjoiY2xoNzRsaDhsMDVqMjNscXNsYjQ3Z2VpeiJ9.AQI-8YZp694_Y3OZ83AYQw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
      'limit' : 7
    });


    super.onRequest(options, handler);
  }

}
