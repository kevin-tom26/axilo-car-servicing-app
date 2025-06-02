import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show debugPrint;

class ReviewService {
  Future<void> addReview(String providerId, Map<String, dynamic> review) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final DocumentReference docRef = firestore.collection('ServiceProviderTable').doc(providerId);

      await docRef.update({
        'reviews': FieldValue.arrayUnion([review])
      });
    } on FirebaseException catch (e) {
      debugPrint('Error Failed to add review: ${e.message}');
      rethrow;
    }
  }
}
