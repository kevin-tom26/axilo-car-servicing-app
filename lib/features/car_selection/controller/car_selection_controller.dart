// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/car_selection/model/vehicle_detail_model.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/car_selection/service/car_selection_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CarSelectionController extends GetxController {
  final CarSelectionService _carSelectionService = CarSelectionService();
  var isVehicleListLoading = true.obs;
  var isCarBrandsLoading = true.obs;
  var isCarModelLoading = true.obs;
  final Uuid _uuid = const Uuid();
  bool fromProfile = false;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      fromProfile = args['from_profile'] ?? false;
    }
    callApis();
  }

  @override
  void onClose() {
    // carBrandController.dispose();
    // carModelController.dispose();
    plateController.dispose();
    carModelSuggestionsController.dispose();
    super.onClose();
  }

  TextEditingController carBrandController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  final plateController = TextEditingController();
  final SuggestionsController<CarModel> carModelSuggestionsController = SuggestionsController<CarModel>();

  var carType = ''.obs;
  final vehicles = <Vehicle>[].obs;
  final selectedVehicle = Rxn<Vehicle>();

  RxList<CarBrand> carBrandsList = <CarBrand>[].obs;
  var selectedBrandID = ''.obs;
  RxList<CarModel> carModelsList = <CarModel>[].obs;
  Map<String, dynamic> newCarData = <String, dynamic>{};

  void selectVehicle(Vehicle vehicleObj) {
    selectedVehicle.value = vehicleObj;
  }

  bool isSelected(Vehicle vehicleObj) => selectedVehicle.value == vehicleObj;

  void setCarBrand(CarBrand value) {
    carBrandController.text = value.brand;
    selectedBrandID.value = value.id;
    carModelController.clear();
    carModelSuggestionsController.refresh();
  }

  void fieldReset() {
    selectedBrandID.value = '';
    carType.value = '';
  }

  Future<void> callApis() async {
    await fetchAllUserVehicles();
    await fetchAllCarBrands();
  }

  Future<void> fetchAllUserVehicles() async {
    isVehicleListLoading.value = true;
    try {
      final data = await _carSelectionService.fetchAllUserVehicles();
      vehicles.assignAll(data.map((doc) => Vehicle.fromJson(doc.data())));
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error fetching user vehicles list';
      CommonMethods.showErrorSnackBar('Error', msg);
    } finally {
      isVehicleListLoading.value = false;
    }
  }

  Future<void> fetchAllCarBrands() async {
    isCarBrandsLoading.value = true;
    try {
      final data = await _carSelectionService.fetchAllCarBrands();
      carBrandsList.assignAll(data.map((doc) => CarBrand.fromJson(doc.data())));
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error fetching car brands list';
      CommonMethods.showErrorSnackBar('Error', msg);
    } finally {
      isCarBrandsLoading.value = false;
    }
  }

  Future<void> getCarModelListById() async {
    isCarModelLoading.value = true;
    carModelsList.clear();
    try {
      final data = await _carSelectionService.fetchAllCarModels(selectedBrandID.value);
      List<Map<String, dynamic>>.from(data).forEach((car) => carModelsList.add(CarModel.fromJson(car)));
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error fetching car model list';
      CommonMethods.showErrorSnackBar('Error', msg);
    } finally {
      isCarModelLoading.value = false;
    }
  }

  List<CarBrand> filteredCarBrandList(String brandName) {
    return carBrandsList
        .where((suggestion) => suggestion.brand.toLowerCase().startsWith(brandName.toLowerCase()))
        .toList();
  }

  List<CarModel> filteredCarModelList(String modelName) {
    return carModelsList
        .where((suggestion) => suggestion.model.toLowerCase().startsWith(modelName.toLowerCase()))
        .toList();
  }

  bool addCarValidation() {
    if (carBrandController.text.isEmpty || carModelController.text.isEmpty) {
      CommonMethods.showErrorSnackBar('Error', 'Please select a Brand and Model.');

      return true;
    } else if (plateController.text.isEmpty) {
      CommonMethods.showErrorSnackBar('Error', 'Please enter a valid plate number.');

      return true;
    }
    return false;
  }

  Future<bool> addCar() async {
    var carId = _uuid.v4();
    newCarData = {
      'user_id': LocalData().userId,
      "id": carId,
      "name": '${carBrandController.text} ${carModelController.text}',
      "type": carType.value,
      "plate": plateController.text
    };
    Vehicle newVehicle = Vehicle.fromJson(newCarData);
    CommonMethods.showLoading();
    try {
      await _carSelectionService.addNewVehicle(vehicle: newCarData);
      vehicles.insert(0, newVehicle);
      selectedVehicle.value = newVehicle;
      CommonMethods.hideLoading();
      return true;
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Failed to add User Vehicle';
      CommonMethods.hideLoading();
      CommonMethods.showErrorSnackBar('Error', msg);
      return false;
    }
  }
}


// Future<void> addSingleVehicle(Map<String, dynamic> vehicleData) async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   final String userId = vehicleData['user_id'];
//   final String vehicleId = vehicleData['id'];

//   await firestore
//       .collection('UserVehicleTable')
//       .doc(userId)
//       .collection('vehicles')
//       .doc(vehicleId)
//       .set(vehicleData);
// }