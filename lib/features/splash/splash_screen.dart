import 'package:axilo/features/auth/service/auth_service.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  bool navigated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _navigate);
  }

  void _navigate() async {
    final user = await FirebaseAuth.instance.authStateChanges().first;
    if (!navigated) {
      navigated = true;
      if (user != null) {
        await _authService.processLogin(user);
        Get.offAllNamed(AppRoutes.main_screen);
      } else {
        Get.offAllNamed(AppRoutes.signIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF673AB7),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: WColors.onPrimary,
          image: DecorationImage(
            image: AssetImage(WImages.splashImg),
            fit: BoxFit.fill,
            // alignment: Alignment.topCenter,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
