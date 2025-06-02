import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/car_selection/controller/car_selection_controller.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/car_selection/ui/screen/add_car_screen.dart';
import 'package:axilo/features/car_selection/ui/widget/vehicle_tile.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarSelectionScreen extends StatelessWidget {
  CarSelectionScreen({super.key});
  final _vehicleController = Get.put(CarSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Select Vehicle', actions: [
        Padding(
          padding: EdgeInsets.only(right: Get.width * 0.035),
          child: IconButton(
            onPressed: () => Get.to(() => AddVehicleScreen()),
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
                backgroundColor: WColors.primary, side: const BorderSide(color: WColors.mainContainer)),
          ),
        ),
      ]),
      body: BottomSafeArea(
        bottom: _vehicleController.fromProfile,
        child: Obx(() {
          bool loading = _vehicleController.isVehicleListLoading.value;
          List<Vehicle> vehicles = _vehicleController.vehicles;

          if (loading) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
              color: WColors.onPrimary,
              size: 40,
            ));
          }

          if (!loading && vehicles.isEmpty) {
            return Center(
                child: ElevatedButton.icon(
              onPressed: () => Get.to(() => AddVehicleScreen()),
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text("Add Vehicle  ",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
            ));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: vehicles.length,
                  padding: const EdgeInsets.only(top: 8),
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final v = vehicles[index];
                      final isSelected = _vehicleController.fromProfile ? false : _vehicleController.isSelected(v);
                      return VehicleTile(
                          onTap: () => _vehicleController.selectVehicle(v),
                          carName: v.name,
                          carType: v.type,
                          numberPlate: v.plate,
                          isSelected: isSelected,
                          assetColor: v.assetColor);
                    });
                  },
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: _vehicleController.fromProfile
          ? SizedBox()
          : BottomSafeArea(
              child: Obx(() {
                return BottomButton(
                    onPressed: _vehicleController.selectedVehicle.value == null
                        ? null
                        : () {
                            Get.toNamed(AppRoutes.slot_booking_screen);
                          },
                    buttonChild: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: _vehicleController.selectedVehicle.value == null
                              ? WColors.darkerGrey
                              : WColors.textSecondary,
                          fontWeight: FontWeight.w500),
                    ));
              }),
            ),
    );
  }
}
