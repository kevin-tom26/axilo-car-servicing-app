import 'package:axilo/core/model/car_wash_model.dart';
import 'package:get/get.dart';

class CarWashDetailController extends GetxController {
  late CarWashModel carWashModelObj;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      carWashModelObj = args['car_wash_model'];
    }
    super.onInit();
  }

  var selectedTabIndex = 0.obs;
  final List<String> carWashTabs = ['About', 'Services', 'Gallery', 'Reviews'];

  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
  }
}
