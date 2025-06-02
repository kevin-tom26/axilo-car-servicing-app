// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/main/controller/main_controller.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../../utils/constants/colors.dart';

class CommonMethods {
  static String getServiceIcon(String serviceName) {
    final match = LocalData.serviceCategories.firstWhere(
      (item) => item['name'] == serviceName,
      orElse: () => {},
    );
    return match['icon'] ?? WImages.error;
  }

  static String timeDiff(DateTime isoDateString) {
    final dateTime = isoDateString.toLocal();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }

  static SnackbarController showSuccessSnackBar(String title, String message) {
    CommonMethods.closeKeyboard(Get.context!);
    return Get.snackbar(
      title,
      '',
      messageText: Text(
        message,
        softWrap: true,
        maxLines: 3,
        style: TextStyle(color: WColors.textSecondary),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: WColors.success.withOpacity(0.6),
      colorText: WColors.textSecondary,
      icon: const Icon(Icons.check_circle_rounded, color: WColors.primary),
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  static void showErrorSnackBar(String title, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonMethods.closeKeyboard(Get.context!);
      Get.snackbar(
        title,
        '',
        messageText: Text(
          message,
          softWrap: true,
          maxLines: 3,
          style: TextStyle(color: WColors.textSecondary),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: WColors.error.withOpacity(0.6),
        colorText: WColors.textSecondary,
        icon: const Icon(Icons.error, color: WColors.primary),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    });
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void showLoading() {
    Get.dialog(
      Center(
          child: LoadingAnimationWidget.dotsTriangle(
        color: WColors.onPrimary,
        size: 40,
      )),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  static void navigateBackToHomeTab() {
    Get.until((route) => route.settings.name == AppRoutes.main_screen);
    final MainController mainController = Get.find<MainController>();
    mainController.currentIndex.value = 0;
  }

  static double? getDistance({LatLng? src, required LatLng dest}) {
    if (LocalData().myLocation.value != null) {
      final dist = Geolocator.distanceBetween(
        src?.latitude ?? LocalData().myLocation.value!.latitude,
        src?.longitude ?? LocalData().myLocation.value!.longitude,
        dest.latitude,
        dest.longitude,
      );
      return dist / 1000;
    }
    return null;
  }

  static String formatDistanceValue(double value) {
    if (value >= 1000) {
      return '>1000';
    } else if (value > 100) {
      final rounded = value.round();
      return value == rounded ? '$rounded' : '~$rounded';
    } else {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
  }

  static final getRandomCarColor = (() {
    final List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      WColors.onPrimary,
      Colors.deepOrange,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
      Colors.deepPurpleAccent,
      Colors.blueGrey,
      Colors.orangeAccent,
      Colors.indigoAccent,
      Colors.tealAccent.shade700,
      Colors.lightGreen.shade700,
      Colors.pinkAccent.shade400,
    ];

    int currentIndex = 0;

    return () {
      final color = colorList[currentIndex];
      currentIndex = (currentIndex + 1) % colorList.length;
      return color;
    };
  })();

  static String generateShortUuid() {
    return Uuid().v4().replaceAll('-', '').toUpperCase().substring(0, 10);
  }

  static String formatDate(String inputDate) {
    final originalFormat = DateFormat('dd MMM, yyyy');
    final newFormat = DateFormat('dd MMM, yy');

    final parsedDate = originalFormat.parse(inputDate);
    return newFormat.format(parsedDate);
  }

  static Future<LatLng?> getCurrentLocation() async {
    Location location = Location();

    while (true) {
      try {
        // 1. Check if location service is enabled
        bool serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            log("User refused to enable location service.");
            return null; // User does not want to enable service
          }
        }

        // 2. Check permission status
        PermissionStatus permissionGranted = await location.hasPermission();

        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();

          if (permissionGranted == PermissionStatus.denied) {
            log("User denied permission.");
            continue; // Ask again
          } else if (permissionGranted == PermissionStatus.deniedForever) {
            log("Permission permanently denied.");
            return null; // Can't request again — must go to settings
          }
        } else if (permissionGranted == PermissionStatus.deniedForever) {
          log("Permission permanently denied.");
          return null;
        }

        // 3. Get current location
        LocationData locationData = await location.getLocation();
        if (locationData.latitude != null && locationData.longitude != null) {
          LocalData().myLocation.value = LatLng(locationData.latitude!, locationData.longitude!);
          return LatLng(locationData.latitude!, locationData.longitude!);
        }
      } catch (e) {
        log("Error getting location: $e");
        return null; // Optional: retry or notify user
      }
    }
  }
}
