import 'package:axilo/core/model/car_wash_model.dart';
import 'package:get/get.dart';

class ServiceSelectionController extends GetxController {
  var serviceProviderName = 'N/A'.obs;

  List<Service> serviceList = [];

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      serviceProviderName.value = args['providerName'] ?? serviceProviderName.value;
      serviceList = List<Service>.from(args['service_list'] ?? []);
    }
    super.onInit();
  }

  //final selectedServiceIds = <String>[].obs;
  final selectedServices = <Service>[].obs;
  final total = 0.0.obs;
  final durationTotal = 0.obs;

  void toggleService(Service service, double price, int duration) {
    if (isSelectedService(service)) {
      selectedServices.remove(service);
      total.value -= price;
      durationTotal.value -= duration;
    } else {
      selectedServices.add(service);
      total.value += price;
      durationTotal.value += duration;
    }
  }

  //bool isSelected(String id) => selectedServiceIds.contains(id);
  bool isSelectedService(Service service) => selectedServices.contains(service);
}
