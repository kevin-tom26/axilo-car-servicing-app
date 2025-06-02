import 'package:axilo/core/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarSelectionService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchAllUserVehicles() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('UserVehicleTable')
          .doc(LocalData().userId)
          .collection('vehicles')
          .get();
      return snapshot.docs;
    } on FirebaseException catch (e) {
      debugPrint('Error fetching user vehicles list: $e');
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchAllCarBrands() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('car_brands').get();
      return snapshot.docs;
    } on FirebaseException catch (e) {
      debugPrint('Error fetching car brands list: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> fetchAllCarModels(String brandId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('carModelsAndType').doc(brandId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final List<dynamic> cars = data?['cars'] ?? [];
        return cars;
      }
      return [];
    } on FirebaseException catch (e) {
      debugPrint('Error fetching car model list: $e');
      rethrow;
    }
  }

  Future<void> addNewVehicle({
    required Map<String, dynamic> vehicle,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference vehicleCollection =
          firestore.collection('UserVehicleTable').doc(LocalData().userId).collection('vehicles');
      final vehicleId = vehicle['id'];
      await vehicleCollection.doc(vehicleId).set(vehicle);
    } on FirebaseException catch (e) {
      debugPrint('Error Failed to add new Vehicle: ${e.message}');
      rethrow;
    }
  }
}
