import 'package:axilo/core/local/user_local_data.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData with UserLocalData {
  static LocalData? _instance;
  factory LocalData() => _instance ??= LocalData._();
  LocalData._();
  cleanUp() {
    super.userCleanUp();
  }

  Rxn<LatLng> myLocation = Rxn<LatLng>();
  RxnBool isLocationReady = RxnBool();

  Map<String, dynamic> sendData() {
    return {};
  }

  static List<Map<String, String>> serviceCategories = [
    {"icon": WImages.exteriorCleaning, "name": "Exterior Cleaning"},
    {"icon": WImages.interiorCleaning, "name": "Interior Cleaning"},
    {"icon": WImages.engineCleaning, "name": "Engine Bay Cleaning"},
    {"icon": WImages.tyreCare, "name": "Tyre & Rim Care"},
    {"icon": WImages.interiorRepair, "name": "Interior Repair"},
    {"icon": WImages.undercarriageWash, "name": "Undercarriage Wash"},
    {"icon": WImages.windshieldCare, "name": "Windshield Treatment"},
    {"icon": WImages.paintProtection, "name": "Paint Protection"},
  ];

  final List<Map<String, dynamic>> dummyNotificationForTesting = <Map<String, dynamic>>[
    {
      "notification_icon": WImages.n_book,
      "notification_title": "Service Booked Successfully",
      "notification_content": "Your service at Clean & Spa has been booked.",
      "timestamp": DateTime.now().subtract(const Duration(hours: 1)).toString(),
      "isMessageRead": false,
    },
    {
      "notification_icon": WImages.n_ticket,
      "notification_title": "50% Off on Exterior Cleaning..",
      "notification_content":
          "Give your car a fresh shine at half the price! Limited-time offer on exterior cleaning. Book now!",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)).toString(),
      "isMessageRead": false,
    },
    {
      "notification_icon": WImages.n_star,
      "notification_title": "Service Review Request",
      "notification_content":
          "We hope you enjoyed your recent car wash service. Your feedback helps us serve you better — tap to leave a quick review!",
      "timestamp": DateTime.now().subtract(const Duration(hours: 3)).toString(),
      "isMessageRead": false,
    },
    {
      "notification_icon": WImages.n_book,
      "notification_title": "Service Booked Successfully",
      "notification_content":
          "Your service at Kings Elegance has been booked. You’ll receive reminders as your appointment approaches.",
      "timestamp": DateTime.now().subtract(const Duration(days: 1, hours: 1)).toString(),
      "isMessageRead": true,
    },
    {
      "notification_icon": WImages.n_wallet,
      "notification_title": "New Paypal Added",
      "notification_content":
          "New PayPal method added to your wallet. Choose it at checkout for a quick and safe payment experience.",
      "timestamp": DateTime.now().subtract(const Duration(days: 1, hours: 2)).toString(),
      "isMessageRead": true,
    },
    {
      "notification_icon": WImages.n_book,
      "notification_title": "Service Booked Successfully",
      "notification_content":
          "Your service at Crystal Car Care has been booked. You’ll receive reminders as your appointment approaches.",
      "timestamp": DateTime.now().subtract(const Duration(days: 3)).toString(),
      "isMessageRead": true,
    },
  ];
}
