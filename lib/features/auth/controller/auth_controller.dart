import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/features/auth/service/auth_service.dart';
import 'package:axilo/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  final Uuid _uuid = Uuid();
  AuthService authService = AuthService();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }

  // Form fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final isPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  //SignIn
  void signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!GetUtils.isEmail(email)) {
      CommonMethods.showErrorSnackBar("Invalid Email", "Please enter a valid email");
      return;
    }

    if (password.length < 6) {
      CommonMethods.showErrorSnackBar("Invalid Password", "Password must be at least 6 characters");
      return;
    }

    try {
      CommonMethods.showLoading();
      await authService.signInWithEmailAndPassword(email, password);
      CommonMethods.hideLoading();
      CommonMethods.showSuccessSnackBar("Success", "Signed in successfully");
      Get.offAllNamed(AppRoutes.main_screen);
    } catch (e) {
      CommonMethods.hideLoading();
      final msg = e is FirebaseAuthException ? e.message ?? "Authentication error" : "An unknown error occurred";
      CommonMethods.showErrorSnackBar("Error", msg);
    }
  }

  //SignUp
  void signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty) {
      CommonMethods.showErrorSnackBar("Invalid Name", "Please enter your name");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      CommonMethods.showErrorSnackBar("Invalid Email", "Please enter a valid email");
      return;
    }

    if (password.length < 6) {
      CommonMethods.showErrorSnackBar("Invalid Password", "Password must be at least 6 characters");
      return;
    }

    try {
      CommonMethods.showLoading();
      await authService.signUpWithEmailAndPassword(name, email, password, _uuid.v4());
      CommonMethods.hideLoading();
      CommonMethods.showSuccessSnackBar("Success", "Account created successfully");
      Get.offAllNamed(AppRoutes.main_screen);
    } catch (e) {
      CommonMethods.hideLoading();
      CommonMethods.showErrorSnackBar("Error", e.toString());
    }
  }
}
