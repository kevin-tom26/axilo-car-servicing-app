import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/slot_booking/model/user_address_model.dart';

class BookingModel {
  final String userId;
  final String orderId;
  final String serviceProviderId;
  final String serviceProviderName;
  final String serviceProviderAddress;
  final String serviceProviderRating;
  final String numberOfReview;
  final String thumbImage;
  final double distance;
  final int waitTime;
  final String bookedDate;
  final String bookedTime;
  final Vehicle vehicle;
  final String serviceType;
  final UserAddressModel? pickupDeliveryAddress;
  final List<Service> bookedServices;
  final double taxAndFee;
  final double totalAmount;
  final String? promoCode;
  final String? extraNote;
  String paymentStatus;
  String serviceStatus;

  BookingModel({
    required this.userId,
    required this.orderId,
    required this.serviceProviderId,
    required this.serviceProviderName,
    required this.serviceProviderAddress,
    required this.serviceProviderRating,
    required this.numberOfReview,
    required this.thumbImage,
    required this.distance,
    required this.waitTime,
    required this.bookedDate,
    required this.bookedTime,
    required this.vehicle,
    required this.serviceType,
    this.pickupDeliveryAddress,
    required this.bookedServices,
    required this.taxAndFee,
    required this.totalAmount,
    this.promoCode,
    this.extraNote,
    required this.paymentStatus,
    required this.serviceStatus,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      userId: json['user_id'],
      orderId: json['order_id'],
      serviceProviderId: json['service_provider_id'],
      serviceProviderName: json['service_provider_name'],
      serviceProviderAddress: json['service_provider_address'],
      serviceProviderRating: json['service_provider_rating'],
      numberOfReview: json['no_of_reviews'],
      thumbImage: json['thumb_image'],
      distance: json['distance'],
      waitTime: json['wait_time'],
      bookedDate: json['booked_date'],
      bookedTime: json['booked_time'],
      vehicle: Vehicle.fromJson(json['vehicle']),
      serviceType: json['service_type'],
      pickupDeliveryAddress:
          json['pickup_delivery_address'] != null ? UserAddressModel.fromJson(json['pickup_delivery_address']) : null,
      bookedServices: List<Service>.from(
        (json['booked_services'] as List).map((x) => Service.fromJson(x)),
      ),
      taxAndFee: json['tax_and_fee'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      promoCode: json['promo_code'],
      extraNote: json['extra_note'],
      paymentStatus: json['payment_status'],
      serviceStatus: json['service_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'order_id': orderId,
      'service_provider_id': serviceProviderId,
      'service_provider_name': serviceProviderName,
      'service_provider_address': serviceProviderAddress,
      'service_provider_rating': serviceProviderRating,
      'no_of_reviews': numberOfReview,
      'thumb_image': thumbImage,
      'distance': distance,
      'wait_time': waitTime,
      'booked_date': bookedDate,
      'booked_time': bookedTime,
      'vehicle': vehicle.toJson(),
      'service_type': serviceType,
      'pickup_delivery_address': pickupDeliveryAddress,
      'booked_services': bookedServices.map((s) => s.toJson()).toList(),
      'tax_and_fee': taxAndFee,
      'total_amount': totalAmount,
      'promo_code': promoCode,
      'extra_note': extraNote,
      'payment_status': paymentStatus,
      'service_status': serviceStatus,
    };
  }
}
