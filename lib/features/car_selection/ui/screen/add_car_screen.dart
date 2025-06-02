import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/car_selection/controller/car_selection_controller.dart';
import 'package:axilo/features/car_selection/model/vehicle_detail_model.dart';
import 'package:axilo/features/car_selection/ui/widget/custom_type_ahead.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddVehicleScreen extends StatelessWidget {
  AddVehicleScreen({super.key});

  final CarSelectionController _vehicleController = Get.find<CarSelectionController>();
  @override
  Widget build(BuildContext context) {
    // _vehicleController.fieldReset();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Add Vehicle'),
          body: Obx(() {
            bool loading = _vehicleController.isCarBrandsLoading.value;
            List<CarBrand> carBrandsList = _vehicleController.carBrandsList;

            if (loading) {
              return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                color: WColors.onPrimary,
                size: 40,
              ));
            }
            return Padding(
              padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Brand",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: WColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  //brandTextFiled(),
                  CustomTypeAhead<CarBrand>(
                    hintText: 'Select Brand',
                    suggestionsCallback: (query) {
                      return query.isEmpty ? carBrandsList : _vehicleController.filteredCarBrandList(query);
                    },
                    itemBuilder: (context, brand) => ListTile(title: Text(brand.brand)),
                    onSelected: (car) {
                      _vehicleController.setCarBrand(car);
                      _vehicleController.getCarModelListById();
                    },
                    onControllerReady: (controller) {
                      controller.text = _vehicleController.carBrandController.text;
                      _vehicleController.carBrandController = controller;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Select Car",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: WColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    List<CarModel> carModelsList = _vehicleController.carModelsList;
                    bool loading = _vehicleController.isCarModelLoading.value;
                    bool enabled = _vehicleController.selectedBrandID.isNotEmpty && !loading;
                    //shimmer
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTypeAhead<CarModel>(
                            hintText: 'Select Car',
                            enabled: enabled,
                            suggestionsController: _vehicleController.carModelSuggestionsController,
                            suggestionsCallback: (query) {
                              return query.isEmpty ? carModelsList : _vehicleController.filteredCarModelList(query);
                            },
                            itemBuilder: (context, car) => ListTile(title: Text(car.model)),
                            onSelected: (car) {
                              _vehicleController.carModelController.text = car.model;
                              _vehicleController.carType.value = car.type;
                            },
                            onControllerReady: (controller) {
                              controller.text = _vehicleController.carModelController.text;
                              _vehicleController.carModelController = controller;
                            }),
                        if (loading) SizedBox(height: 4),
                        if (_vehicleController.selectedBrandID.isNotEmpty && loading)
                          Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                            color: WColors.onPrimary,
                            size: 20,
                          ))
                      ],
                    );
                  }),
                  const SizedBox(height: 25),
                  const Text(
                    "Car Number Plate",
                    style: TextStyle(color: WColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _vehicleController.plateController,
                    style: const TextStyle(color: WColors.textPrimary),
                    decoration: InputDecoration(
                        hintText: "Ex. GR 789-IJKL",
                        hintStyle: const TextStyle(color: WColors.darkerGrey, fontWeight: FontWeight.w400),
                        fillColor: WColors.darkGrey.withOpacity(0.2),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: WColors.onPrimary, width: 0.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: WColors.onPrimary, width: 1.5))),
                  ),
                ],
              ),
            );
          }),
          bottomNavigationBar: BottomSafeArea(
            child: BottomButton(
                onPressed: () async {
                  if (_vehicleController.addCarValidation()) return;
                  await _vehicleController.addCar().then((val) {
                    if (val) {
                      Get.back();
                      CommonMethods.showSuccessSnackBar('Success', 'New Vehicle added successfully');
                    }
                  });
                },
                buttonChild: Text("Add Vehicle",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500))),
          )),
    );
  }
}
