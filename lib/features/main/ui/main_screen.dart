import 'package:axilo/features/booking/controller/booking_controller.dart';
import 'package:axilo/features/booking/ui/screen/booking_screen.dart';
import 'package:axilo/features/bookmark/controller/bookmark_controller.dart' show BookmarkController;
import 'package:axilo/features/bookmark/ui/screen/bookmark_screen.dart';
import 'package:axilo/features/explore/controller/explore_controller.dart';
import 'package:axilo/features/explore/ui/screen/explore_screen.dart';
import 'package:axilo/features/help/controller/help_controller.dart';
import 'package:axilo/features/help/ui/screen/help_screen.dart';
import 'package:axilo/features/home/controller/home_controller.dart';
import 'package:axilo/features/home/ui/screen/home_screen.dart';
import 'package:axilo/features/main/controller/main_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ExploreController());
    Get.lazyPut(() => BookmarkController(), fenix: true);
    Get.lazyPut(() => BookingController());
    Get.lazyPut(() => HelpController());

    final List<Widget> pages = [
      const HomeScreen(),
      ExploreScreen(),
      BookmarkScreen(),
      BookingScreen(),
      HelpScreen(),
    ];

    return Scaffold(
      body: Obx(() {
        return pages[mainController.currentIndex.value];
        // IndexedStack(
        //   index: mainController.currentIndex.value,
        //   children: pages,
        // );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: mainController.currentIndex.value,
            backgroundColor: WColors.softGrey,
            onTap: mainController.changeTab,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(color: WColors.onPrimary, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            selectedItemColor: WColors.onPrimary,
            unselectedItemColor: WColors.onSecondary,
            items: List.generate(mainController.bottomNavItems.length, (index) {
              return BottomNavigationBarItem(
                  icon: Image.asset(mainController.bottomNavItems[index]["icon"],
                      scale: 2.9,
                      color: mainController.currentIndex.value == index ? WColors.onPrimary : WColors.onSecondary),
                  label: mainController.bottomNavItems[index]["label"]);
            }));
      }),
    );
  }
}
