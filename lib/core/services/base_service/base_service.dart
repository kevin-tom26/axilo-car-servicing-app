import 'package:axilo/core/module/network_module/network_module.dart';
import 'package:dio/dio.dart';

class BaseService {
  //late DioClient dioClient;
  late Dio dio;
  // late DataSource dataSource;

  /// this is for testing

  BaseService() {
    // dioClient = NetworkModule().provideDioClient(Dio());
    dio = NetworkModule().provideDio();
    // dataSource = LocalModule().provideLocalModule();
  }
}
