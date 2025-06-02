import 'dart:developer';

import 'package:axilo/core/enum/enums.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/services/base_service/base_service.dart';
import 'package:axilo/features/payment/model/stripe_response_model.dart';
import 'package:axilo/utils/config_colection/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';

class StripePayment extends BaseService {
  static StripePayment? _instance;
  factory StripePayment() => _instance ??= StripePayment._();
  StripePayment._();

  //final Dio _dio = Dio();
  Map<String, dynamic>? _paymentIntentData;

  Future<StripeResponse> makePayment({
    required double amount,
    required String currency,
  }) async {
    try {
      // 1. Create Payment Intent
      _paymentIntentData = await _createPaymentIntent(amount, currency);

      if (_paymentIntentData == null || _paymentIntentData!['client_secret'] == null) {
        throw Exception('invalid payment intent data');
      }

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: _paymentIntentData!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Axilo',
          billingDetails: BillingDetails(
            name: LocalData().userName,
            email: LocalData().email,
            phone: '+11234567890',
            address: Address(
              city: 'New York',
              country: 'US',
              line1: '123 Main Street',
              state: 'NY',
              line2: null,
              postalCode: '10001',
            ),
          ),
        ),
      );

      // 3. Display Payment Sheet
      return await _displayPaymentSheet();
    } catch (e) {
      log('Exception: $e');
      return StripeResponse(status: PaymentStatus.failure, message: 'Error: $e');
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(double amount, String currency) async {
    try {
      final response = await dio.post(
        Config.stripeApi,
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
          //'payment_method_types[]': 'card',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to create Payment Intent. Status: ${response.statusCode}, Message: ${response.statusMessage}',
        );
      }
    } catch (e) {
      log('Error creating payment intent: $e');
      rethrow;
    }
  }

  String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).round();
    return calculatedAmount.toString();
  }

  Future<StripeResponse> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return StripeResponse(status: PaymentStatus.success, message: 'Payment successful');
    } on StripeException catch (e) {
      return StripeResponse(
        status: PaymentStatus.failure,
        message: e.error.localizedMessage ?? 'Payment canceled or failed',
      );
    } catch (e) {
      return StripeResponse(status: PaymentStatus.failure, message: 'Unexpected error: $e');
    }
  }
}
