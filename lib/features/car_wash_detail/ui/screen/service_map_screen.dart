import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/features/car_wash_detail/controller/service_map_controller.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ServiceMapScreen extends StatelessWidget {
  ServiceMapScreen({super.key});

  final ServiceMapController mapController = Get.put(ServiceMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
          onLeadingIconPressed: () => Get.back(),
          transparent: true,
          titleWidget: Obx(() {
            return Text(mapController.showRoute.value ? "Get Direction" : mapController.shopName.value);
          })),
      body: Obx(() {
        if (mapController.currentLocation.value == null) {
          return Center(
              child: Text("Please enable GPS and Location Permission",
                  style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16)));
        }
        if (mapController.mapStyle.value == null) {
          return Center(
              child: LoadingAnimationWidget.dotsTriangle(
            color: WColors.onPrimary,
            size: 40,
          ));
        }
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: mapController.showRoute.value
                      ? mapController.currentLocation.value!
                      : mapController.destination.value,
                  zoom: 14),
              onMapCreated: mapController.onMapReady,
              markers: {
                mapController.userMarker,
                mapController.destinationMarker,
              },
              polylines: mapController.showRoute.value ? {mapController.polyline} : {},
              style: mapController.mapStyle.value,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomSafeArea(
        child: BottomButton(
          onPressed: () async {
            if (!mapController.showRoute.value) {
              await mapController.fetchRouteFromOSRM();
            } else {
              await mapController.startNavigation();
            }
          },
          buttonChild: Obx(() => Text(
                mapController.showRoute.value
                    ? mapController.isNavigating.value
                        ? "Navigating..."
                        : "Start"
                    : "Get Direction",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }
}
