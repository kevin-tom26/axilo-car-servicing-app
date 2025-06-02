import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/common/service/review_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  @override
  void onClose() {
    reviewTextController.dispose();
    super.onClose();
  }

  final ReviewService _reviewService = ReviewService();

  var rating = 0.obs;
  var reviewText = ''.obs;
  // var selectedImages = <XFile>[].obs;

  TextEditingController reviewTextController = TextEditingController();

  void setRating(int value) => rating.value = value;

  // void removeImage(int index) => selectedImages.removeAt(index);

  // Future<void> pickImages() async {
  //   final picker = ImagePicker();
  //   final picked = await picker.pickMultiImage();
  //   if (picked.isNotEmpty) {
  //     selectedImages.addAll(picked);
  //   }
  // }

  Future<bool> addReview(String serviceProviderId) async {
    Map<String, dynamic> data = {
      "rating": rating.value,
      "profile_img": LocalData().localUserData.profileImage,
      "comment": reviewTextController.text.trim(),
      "date": DateTime.now().toUtc().toIso8601String(),
      "reviewerName": LocalData().userName,
      "reviewerEmail": LocalData().email
    };
    CommonMethods.showLoading();
    try {
      await _reviewService.addReview(serviceProviderId, data);
      CommonMethods.hideLoading();
      return true;
    } catch (e) {
      CommonMethods.hideLoading();
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Failed to add review';
      CommonMethods.showErrorSnackBar('Error', msg);
      return false;
    }
  }
}
