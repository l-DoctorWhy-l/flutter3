import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  final String apiKey;
  final String headerName;

  ApiKeyInterceptor({required this.apiKey, this.headerName = 'Authorization'});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[headerName] = apiKey;
    super.onRequest(options, handler);
  }
}


