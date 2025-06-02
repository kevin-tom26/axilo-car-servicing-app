import 'package:axilo/core/enum/enums.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchUserBooking() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('UserBookingTable')
          .doc(LocalData().userId)
          .collection('bookings')
          .get();

      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      debugPrint('Error fetching user booking data: $e');
      rethrow;
    }
  }

  Future<void> cancelBooking(String orderID) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('UserBookingTable')
          .doc(LocalData().userId)
          .collection('bookings')
          .doc(orderID);

      await docRef.update({'service_status': ServiceStatus.cancelled.name});
    } on FirebaseException catch (e) {
      debugPrint('Error updating booking status: $e');
      rethrow;
    }
  }
}
