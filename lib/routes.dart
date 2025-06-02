// ignore_for_file: constant_identifier_names

import 'package:axilo/features/auth/ui/screen/sign_in.dart';
import 'package:axilo/features/auth/ui/screen/sign_up.dart';
import 'package:axilo/features/car_wash_detail/ui/screen/navigation_success.dart';
import 'package:axilo/features/car_wash_detail/ui/screen/service_map_screen.dart';
import 'package:axilo/features/notification/ui/screen/notification_screen.dart';
import 'package:axilo/features/profile/ui/screen/edit_profile_screen.dart';
import 'package:axilo/features/profile/ui/screen/profile_screen.dart';
import 'package:axilo/features/provider_listing/ui/screen/provider_listing_screen.dart';
import 'package:axilo/features/car_selection/ui/screen/add_car_screen.dart';
import 'package:axilo/features/car_selection/ui/screen/car_selection_screen.dart';
import 'package:axilo/features/car_wash_detail/ui/screen/car_wash_detail_screen.dart';
import 'package:axilo/features/home/ui/screen/home_screen.dart';
import 'package:axilo/features/review_summary/ui/screen/review_summary_screen.dart';
import 'package:axilo/features/service_selection/ui/screen/service_selection_screen.dart';
import 'package:axilo/features/main/ui/main_screen.dart';
import 'package:axilo/features/user_address/screen/pick_up_addres_screen.dart';
import 'package:axilo/features/slot_booking/ui/screen/slot_booking_screen.dart';
import 'package:axilo/features/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  AppRoutes._();
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String onboarding = '/onboarding';
  static const String main_screen = '/main_screen';
  static const String home = '/home';
  static const String notification_screen = '/notification_screen';
  static const String profile_screen = '/profile_screen';
  static const String edit_profile_screen = '/edit_profile_screen';
  static const String provider_listing_screen = '/provider_listing_screen';
  static const String car_wash_detail = '/car_wash_detail';
  static const String service_map_screen = '/service_map_screen';
  static const String navigation_success_screen = '/navigation_success_screen';
  static const String service_selection = '/service_selection';
  static const String car_selection = '/car_selection';
  static const String add_car_screen = '/add_car_screen';
  static const String slot_booking_screen = '/slot_booking_screen';
  static const String pick_up_addrees_screen = '/pick_up_addrees_screen';
  static const String review_summary_screen = '/review_summary_screen';
  static const String booking = '/booking';
  static const String payment = '/payment';

  static final List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    //GetPage(name: onboarding, page: () => OnBoardScreen()),
    GetPage(name: main_screen, page: () => MainScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: notification_screen, page: () => NotificationScreen()),
    GetPage(name: profile_screen, page: () => ProfileScreen()),
    GetPage(name: edit_profile_screen, page: () => EditProfileScreen()),
    GetPage(name: provider_listing_screen, page: () => ProviderListingScreen()),
    GetPage(name: car_wash_detail, page: () => CarWashDetailScreen()),
    GetPage(name: service_map_screen, page: () => ServiceMapScreen()),
    GetPage(name: navigation_success_screen, page: () => NavigationSuccessScreen()),
    GetPage(name: service_selection, page: () => ServiceSelectionScreen()),
    GetPage(name: car_selection, page: () => CarSelectionScreen()),
    GetPage(name: add_car_screen, page: () => AddVehicleScreen()),
    GetPage(name: slot_booking_screen, page: () => SlotBookingScreen()),
    GetPage(name: pick_up_addrees_screen, page: () => PickUpAddressScreen()),
    GetPage(name: review_summary_screen, page: () => ReviewSummaryScreen()),
    // GetPage(name: booking, page: () => const BookingScreen()),
    // GetPage(name: payment, page: () => const PaymentScreen()),
  ];
}
