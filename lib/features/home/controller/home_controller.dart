// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/core/services/map_services/map_services.dart';
import 'package:axilo/features/main/controller/main_controller.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  MapServices mapService = MapServices();
  late MainController mainController;
  var isFeatureServiceLoading = true.obs;
  var isNearByServiceLoading = true.obs;
  var fullLoading = true.obs;
  var currentPlaceName = 'Unknown'.obs;

  @override
  onInit() {
    super.onInit();
    mainController = Get.find<MainController>();
    ever(mainController.carServicesList, (_) {
      fullLoading.value = true;
      getFeaturedServices();
      if (LocalData().myLocation.value != null) {
        filterNearbyServices();
      } else {
        isLocationPermissionDenied.value = true;
        isNearByServiceLoading.value = false;
      }
      fullLoading.value = false;
    });
  }

  @override
  void onReady() async {
    if (LocalData().myLocation.value != null) {
      getCurrentPlaceName();
    } else {
      ever(LocalData().myLocation, (val) {
        if (val != null) {
          getCurrentPlaceName();
        }
      });
    }

    super.onReady();
  }

  @override
  void onClose() {
    //searchController.dispose();
    super.onClose();
  }

  TextEditingController searchController = TextEditingController();

  var activeIndex = 0.obs;

  var isLocationPermissionDenied = false.obs;

  // Carousel controllers
  final CarouselSliderController offerCarouselController = CarouselSliderController();
  final CarouselSliderController nearbyCarouselController = CarouselSliderController();
  final CarouselSliderController featuredCarouselController = CarouselSliderController();

  // Reactive image list
  final RxList<String> imageList = <String>[
    WImages.car6,
    WImages.car7,
    WImages.car8,
    WImages.car9,
  ].obs;

  // Reactive nearby services list
  RxList<CarWashModel> nearbyServices = <CarWashModel>[].obs;
  RxList<CarWashModel> featuredServices = <CarWashModel>[].obs;

  updateIndex(int index) {
    activeIndex(index);
  }

  Future<void> getFeaturedServices() async {
    isFeatureServiceLoading.value = true;
    featuredServices.assignAll(mainController.carServicesList);
    isFeatureServiceLoading.value = false;
  }

  Future<void> filterNearbyServices() async {
    isNearByServiceLoading.value = true;
    nearbyServices.assignAll(mainController.carServicesList.where((service) {
      final distance = double.tryParse(service.distance ?? '');
      return distance != null && distance <= 20;
    }).toList());

    isNearByServiceLoading.value = false;
  }

  void getCurrentPlaceName() async {
    currentPlaceName.value = await mapService.getPlaceNameFromCoordinates(
        LocalData().myLocation.value!.latitude, LocalData().myLocation.value!.longitude);
  }

  List<CarWashModel> filteredSearchServiceList(String suggestion, RxList<CarWashModel> serviceModelsList) {
    return serviceModelsList
        .where((service) => service.name.toLowerCase().startsWith(suggestion.toLowerCase()))
        .toList();
  }

  void setSelectedService(CarWashModel value) => searchController.text = value.name;

  Future<void> reloadCarServiceList() async {
    await mainController.getServiceProviderList();
  }

  // void getCorrectedDistance() async {
  //   if (isLocationPermissionDenied.value) {
  //     return;
  //   }

  //   // Batch process 5 at a time
  //   const int batchSize = 4;
  //   for (int i = 0; i < featuredServices.length; i += batchSize) {
  //     final batch = featuredServices.skip(i).take(batchSize);

  //     await Future.wait(batch.map((service) async {
  //       final distance = await mapService.getRouteFromOSRM(
  //         LocalData().myLocation.value!.latitude,
  //         LocalData().myLocation.value!.longitude,
  //         service.latlong.latitude,
  //         service.latlong.longitude,
  //       );

  //       service.distance = (distance ?? 0) > 0 ? (distance! / 1000).toStringAsFixed(2) : '-';
  //     }));
  //   }

  //   featuredServices.refresh();
  // }
}
