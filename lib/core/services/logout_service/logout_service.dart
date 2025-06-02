import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/services/base_service/base_service.dart';
import 'package:axilo/routes.dart';
import 'package:get/get.dart';

class LogoutService extends BaseService {
  LogoutService() : super();
  void logout() async {
    LocalData().cleanUp();
    // await dataSource.deleteAuthData();
    Get.offAllNamed(AppRoutes.signIn);
  }
}
