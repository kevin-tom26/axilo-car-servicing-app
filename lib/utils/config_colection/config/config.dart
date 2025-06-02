import 'package:axilo/utils/config_colection/env_file/env_file.dart';

class Config {
  Config._();

  static const bool isProduction = Staging.isProduction;

  static String stripeApi = 'https://api.stripe.com/v1/payment_intents';

  static const String contentTypeApp = 'application/x-www-form-urlencoded';

  // receiveTimeout
  static const int receiveTimeout = 250000;
  // connectTimeout
  static const int connectionTimeout = 230000;
  // for login
  // static const String loginUrl = "$baseUrl/oauth/token";

  static const int splashScreenTimeout = 3000;

  static const String currencySymbol = "₹";

  static const int successStatusCode = 200;

  static const int updateDurationDays = 1;
}
