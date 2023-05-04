import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiYWxleGFuZGVycXVpbmF0b2EiLCJhIjoiY2xoNzRsaDhsMDVqMjNscXNsYjQ3Z2VpeiJ9.AQI-8YZp694_Y3OZ83AYQw';

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
