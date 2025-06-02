import 'package:axilo/core/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddressServices {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchAllUserAddresses() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('UserAddressTable')
          .doc(LocalData().userId)
          .collection('addresses')
          .get();
      return snapshot.docs;
    } on FirebaseException catch (e) {
      debugPrint('Error fetching user Addresses: ${e.message}');
      rethrow;
    }
  }

  Future<void> addNewAddress({
    required Map<String, dynamic> address,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference addressCollection =
          firestore.collection('UserAddressTable').doc(LocalData().userId).collection('addresses');
      await addressCollection.add(address);
    } on FirebaseException catch (e) {
      debugPrint('Error Failed to add User Address: ${e.message}');
      rethrow;
    }
  }
}
