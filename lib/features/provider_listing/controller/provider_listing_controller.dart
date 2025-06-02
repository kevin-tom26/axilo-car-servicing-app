import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderListingController extends GetxController {
  late HomeController homeController;

  var heading = 'Service Provider'.obs;
  var isCategory = false.obs;
  var fromNearBy = false.obs;
  var loading = true.obs;
  var isLocationPermissionDenied = false.obs;

  RxList<CarWashModel> filteredList = <CarWashModel>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      heading.value = args['heading'] ?? heading.value;
      isCategory.value = args['isCategory'] ?? false;
      fromNearBy.value = args['fromNearBy'] ?? false;
    }
    loading = homeController.fullLoading;
    isLocationPermissionDenied = homeController.isLocationPermissionDenied;
  }

  @override
  void onReady() {
    super.onReady();
    assignData();
  }

  void assignData() {
    if (fromNearBy.value) {
      //filterByNearBy();
      filteredList.assignAll(homeController.nearbyServices);
    } else if (isCategory.value) {
      filterByCategory();
    } else {
      filteredList.assignAll(homeController.featuredServices);
    }
  }

  void filterByCategory() {
    filteredList.assignAll(homeController.featuredServices
        .where((item) => item.services.any((category) => category.name == heading.value)));
  }

  List<CarWashModel> filteredServiceList(String suggestion, RxList<CarWashModel> serviceModelsList) {
    return serviceModelsList
        .where((service) => service.name.toLowerCase().startsWith(suggestion.toLowerCase()))
        .toList();
  }

  void setSelectedService(CarWashModel value) => searchController.text = value.name;
}
