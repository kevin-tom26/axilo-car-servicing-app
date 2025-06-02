import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreController extends GetxController {
  @override
  void onInit() {
    setCustomMarker();
    rootBundle.loadString('assets/map_style/light_map.json').then((style) {
      mapStyle.value = style;
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Rxn<String> mapStyle = Rxn<String>();

  TextEditingController searchController = TextEditingController();
  CarouselSliderController exploreCarouselController = CarouselSliderController();

  BitmapDescriptor meMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor shopMarker = BitmapDescriptor.defaultMarker;

  void setCustomMarker() {
    BitmapDescriptor.asset(ImageConfiguration.empty, WImages.my_marker).then((icon) {
      meMarker = icon;
    });

    BitmapDescriptor.asset(ImageConfiguration.empty, WImages.shop_marker).then((icon) {
      shopMarker = icon;
    });
  }

  List<CarWashModel> filteredServiceList(String suggestion, RxList<CarWashModel> serviceModelsList) {
    return serviceModelsList
        .where((service) => service.name.toLowerCase().startsWith(suggestion.toLowerCase()))
        .toList();
  }

  void setSelectedService(CarWashModel value) => searchController.text = value.name;

  Set<Marker> getMapMarkers(List<CarWashModel> services, LatLng userLocation) {
    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId("me"),
        position: userLocation,
        icon: meMarker,
        infoWindow: const InfoWindow(title: "You"),
      ),
    };

    markers.addAll(
      services.map((shop) => Marker(
            markerId: MarkerId(shop.id),
            position: LatLng(shop.latlong.latitude, shop.latlong.longitude),
            icon: shopMarker,
            infoWindow: InfoWindow(title: shop.name, snippet: shop.address),
          )),
    );

    return markers;
  }

  Set<Circle> getMapCircles(LatLng userLocation) {
    return {
      Circle(
        circleId: const CircleId('25km_radius'),
        center: userLocation,
        radius: 23000,
        fillColor: const Color.fromARGB(51, 199, 80, 199),
        strokeColor: const Color(0x66800080),
        strokeWidth: 2,
      ),
    };
  }
}
