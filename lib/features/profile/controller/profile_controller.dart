import 'dart:developer';
import 'dart:io';

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/services/logout_service/logout_service.dart';
import 'package:axilo/features/auth/model/user_model.dart';
import 'package:axilo/features/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final LogoutService _logoutService = LogoutService();
  ProfileService profileService = ProfileService();
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  Rxn<File> selectedImage = Rxn<File>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void getUserData() {
    currentUser.value = LocalData().localUserData;
    nameController.text = currentUser.value!.name;
    emailController.text = currentUser.value!.email;
    phoneController.text = currentUser.value!.phone ?? '';
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 75);

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<bool> validateFields() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      CommonMethods.showErrorSnackBar('Invalid Input', 'Name cannot be empty');
      return false;
    }
    if ((phone.isNotEmpty && phone.length != 10) || int.tryParse(phone) == null) {
      CommonMethods.showErrorSnackBar('Invalid Phone', 'Phone number must be 10 digits');
      return false;
    }

    await updateUserInfo();
    return true;
  }

  Future<void> updateUserInfo() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    String? imageUrl;

    currentUser.update((user) {
      user!.name = name;
      user.email = email;
      user.phone = phone;
    });

    try {
      if (selectedImage.value != null) {
        imageUrl = await profileService.uploadImageToImgBBWithDio(selectedImage.value!);
      }

      final updateData = {
        'name': name,
        'profileImage': imageUrl, // null or actual URL
        'phone': phone,
      };

      await profileService.updateUserProfile(updateData);
      log('${LocalData().localUserData}');
      Get.back();
    } catch (e) {
      final msg = e is FirebaseException
          ? e.message ?? "Database error"
          : e is FirebaseAuthException
              ? e.message ?? "Email update failed"
              : "User profile update failed";
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }

  Future<void> logout() async {
    CommonMethods.showLoading();
    await FirebaseAuth.instance.signOut().then((_) {
      _logoutService.logout();
      CommonMethods.hideLoading();
    });
  }
}
