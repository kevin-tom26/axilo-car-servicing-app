import 'package:axilo/utils/config_colection/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkModule {
  static NetworkModule? _instance;
  factory NetworkModule() => _instance ??= NetworkModule._();
  NetworkModule._();

  Dio provideDio() {
    final dio = Dio();

    dio
      //..options.baseUrl = Config.baseUrl
      ..options.connectTimeout = const Duration(milliseconds: Config.connectionTimeout)
      ..options.receiveTimeout = const Duration(milliseconds: Config.receiveTimeout)
      ..interceptors.add(LogInterceptor(
        request: kDebugMode ? true : false,
        responseBody: kDebugMode ? true : false,
        requestBody: kDebugMode ? true : false,
        requestHeader: kDebugMode ? true : false,
      ));
    // ..interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     var token = LocalData().accessToken;
    //     if (token != null) {
    //       options.headers.putIfAbsent("Authorization", () => "Bearer $token");
    //     }
    //     handler.next(options);
    //   },
    // ));
    return dio;
  }

  //DioClient provideDioClient(Dio dio) => DioClient(provideDio());
}
