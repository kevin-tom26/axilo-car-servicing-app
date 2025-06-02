import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MainService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getServiceProviderList() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('ServiceProviderTable').get();

      return snapshot.docs;
    } on FirebaseException catch (e) {
      debugPrint('Error fetching car wash data: $e');
      rethrow;
    }
  }
}
