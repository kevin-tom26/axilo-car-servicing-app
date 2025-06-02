import 'package:axilo/core/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewSummaryService {
  Future<void> bookService(Map<String, dynamic> booking) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final String userId = LocalData().userId;
      final String orderId = booking['order_id'];

      final DocumentReference docRef =
          firestore.collection('UserBookingTable').doc(userId).collection('bookings').doc(orderId);

      await docRef.set(booking);
    } on FirebaseException catch (e) {
      debugPrint('Error service booking failed: ${e.message}');
      rethrow;
    }
  }

  Future<void> updateBookig(String orderId, Map<String, dynamic> updateData) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final String userId = LocalData().userId;

      final DocumentReference docRef =
          firestore.collection('UserBookingTable').doc(userId).collection('bookings').doc(orderId);

      await docRef.update(updateData);
    } on FirebaseException catch (e) {
      debugPrint('Error Payment status update failed: ${e.message}');
      rethrow;
    }
  }
}
