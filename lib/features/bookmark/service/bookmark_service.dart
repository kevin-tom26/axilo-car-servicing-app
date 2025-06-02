import 'package:axilo/core/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookmarkService {
  Stream<List<String>> listenToBookmarks() {
    try {
      return FirebaseFirestore.instance.collection('UserBookmarks').doc(LocalData().userId).snapshots().map((snapshot) {
        final data = snapshot.data();
        if (data == null || data['bookmarks'] == null) return [];
        return List<String>.from(data['bookmarks']);
      });
    } on FirebaseException catch (e) {
      debugPrint('Error fetching bookMark List: $e');
      rethrow;
    }
  }

  Future<void> updateUserBookmark({required bool isAdding, required String bookmarkID}) async {
    final docRef = FirebaseFirestore.instance.collection('UserBookmarks').doc(LocalData().userId);
    try {
      if (isAdding) {
        await docRef.set({
          'bookmarks': FieldValue.arrayUnion([bookmarkID])
        }, SetOptions(merge: true));
      } else {
        await docRef.update({
          'bookmarks': FieldValue.arrayRemove([bookmarkID])
        });
      }
    } on FirebaseException catch (e) {
      debugPrint('Error updating bookMark List: $e');
      rethrow;
    }
  }
}
