import 'package:flutter/material.dart';

class GlobalAppContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<ScaffoldState> bottomNavKey = GlobalKey<ScaffoldState>();
}
