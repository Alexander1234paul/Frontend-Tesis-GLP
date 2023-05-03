import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1IjoiYWxleGFuZGVycXVpbmF0b2EiLCJhIjoiY2xoNzRsaDhsMDVqMjNscXNsYjQ3Z2VpeiJ9.AQI-8YZp694_Y3OZ83AYQw';

class TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}
