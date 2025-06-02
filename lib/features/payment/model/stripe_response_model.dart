import 'package:axilo/core/enum/enums.dart';

class StripeResponse {
  final PaymentStatus status;
  final String message;

  StripeResponse({required this.status, required this.message});
}
