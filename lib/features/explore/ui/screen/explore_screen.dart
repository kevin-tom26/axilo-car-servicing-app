import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/common/widgets/custom_search_bar/custom_search_bar.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/explore/controller/explore_controller.dart';
import 'package:axilo/features/explore/ui/widget/car_services_list.dart';
import 'package:axilo/features/main/controller/main_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreController exploreController = Get.find<ExploreController>();
    final MainController mainController = Get.find<MainController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: BottomSafeArea(
          child: Obx(() {
            if (LocalData().isLocationReady.value == null) {
              return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                color: WColors.onPrimary,
                size: 40,
              ));
            } else if (!LocalData().isLocationReady.value!) {
              return Center(
                  child: Text("Please enable GPS and Location Permission",
                      style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16)));
            }
            /////
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LocalData().myLocation.value!,
                    zoom: 10,
                  ),
                  markers: exploreController.getMapMarkers(
                    mainController.carServicesList,
                    LocalData().myLocation.value!,
                  ),
                  circles: exploreController.getMapCircles(LocalData().myLocation.value!),
                  style: exploreController.mapStyle.value,
                  onMapCreated: (controller) {},
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: CarServiceList(
                      carouselContoller: exploreController.exploreCarouselController,
                      serviceProviderList: mainController.carServicesList,
                    )),
                Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: CustomSerachBar<CarWashModel>(
                        hintText: 'Search Service',
                        borderEnabled: true,
                        suggestionsCallback: (query) {
                          return query.isEmpty
                              ? mainController.carServicesList
                              : exploreController.filteredServiceList(query, mainController.carServicesList);
                        },
                        itemBuilder: (context, service) => ListTile(title: Text(service.name)),
                        onSelected: (car) {
                          exploreController.setSelectedService(car);
                        },
                        onControllerReady: (controller) {
                          exploreController.searchController = controller;
                        }))
              ],
            );
          }),
        ),
      ),
    );
  }
}
