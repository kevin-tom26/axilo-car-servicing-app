import 'dart:async';
import 'dart:math';

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/services/map_services/map_services.dart';
import 'package:axilo/features/car_wash_detail/controller/car_wash_detail_controller.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ServiceMapController extends GetxController {
  late CarWashDetailController carWashController;
  StreamSubscription<LocationData>? liveLocationStream;
  Rxn<String> mapStyle = Rxn<String>();
  Location location = Location();
  Rxn<LatLng> currentLocation = Rxn<LatLng>();
  Rx<LatLng> destination = Rx<LatLng>(LatLng(0, 0));
  RxList<LatLng> routePoints = <LatLng>[].obs;
  RxBool isNavigating = false.obs;
  RxBool showRoute = false.obs;
  var shopName = 'Washing Center Location'.obs;

  @override
  void onInit() {
    carWashController = Get.find<CarWashDetailController>();
    rootBundle.loadString('assets/map_style/light_map.json').then((style) {
      mapStyle.value = style;
    });
    shopName.value = carWashController.carWashModelObj.name;
    currentLocation = LocalData().myLocation;
    destination =
        LatLng(carWashController.carWashModelObj.latlong.latitude, carWashController.carWashModelObj.latlong.longitude)
            .obs;
    super.onInit();
  }

  @override
  onClose() {
    stopLiveTracking();
    super.onClose();
  }

  MapServices mapServices = MapServices();

  late GoogleMapController mapController;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor navMarkerIcon = BitmapDescriptor.defaultMarker;

  Marker get userMarker => Marker(
        markerId: MarkerId('user'),
        position: currentLocation.value!,
        icon: userMarkerIcon,
      );

  Marker get destinationMarker => Marker(
        markerId: MarkerId('dest'),
        position: destination.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      );

  Polyline get polyline => Polyline(
        polylineId: PolylineId("route"),
        color: Colors.black,
        width: 4,
        points: routePoints,
      );

  Future<void> initNavigation() async {
    BitmapDescriptor.asset(ImageConfiguration(size: Size(40, 40)), WImages.my_marker).then((icon) {
      userMarkerIcon = icon;
    });

    // Zoom to fit both markers
    await Future.delayed(Duration(milliseconds: 500)); // let map render
    zoomToFitMarkers();
  }

  void zoomToFitMarkers() {
    if (currentLocation.value == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        min(currentLocation.value!.latitude, destination.value.latitude),
        min(currentLocation.value!.longitude, destination.value.longitude),
      ),
      northeast: LatLng(
        max(currentLocation.value!.latitude, destination.value.latitude),
        max(currentLocation.value!.longitude, destination.value.longitude),
      ),
    );
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  Future<void> fetchRouteFromOSRM() async {
    CommonMethods.showLoading();
    final coords = await mapServices.fetchRouteFromOSRM(currentLocation.value!.latitude,
        currentLocation.value!.longitude, destination.value.latitude, destination.value.longitude);
    routePoints.assignAll(coords.map((c) => LatLng(c.latitude, c.longitude)));
    showRoute.value = true;
    CommonMethods.hideLoading();
  }

  Future<void> startNavigation() async {
    isNavigating.value = true;

    liveLocationStream = location.onLocationChanged.listen((locationData) {
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);
      currentLocation.value = latLng;

      mapController.animateCamera(CameraUpdate.newLatLng(latLng));

      final distanceToDest = CommonMethods.getDistance(
        src: latLng,
        dest: destination.value,
      );

      if (distanceToDest != null && distanceToDest <= 10) {
        stopNavigation(); // cancel listener, stop marker update
        Get.offNamed(AppRoutes.navigation_success_screen);
      }
    });
  }

  void stopLiveTracking() {
    liveLocationStream?.cancel();
    isNavigating.value = false;
  }

  void stopNavigation() {
    stopLiveTracking();
    showRoute.value = false;
  }

  void onMapReady(GoogleMapController controller) {
    mapController = controller;
    initNavigation();
  }
}
