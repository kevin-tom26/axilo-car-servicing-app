import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  @override
  onClose() {
    userQuestionController.dispose();
    super.onClose();
  }

  final Map<String, String> faqData = {
    "How do I book a car wash?":
        "You can book a car wash by selecting a location, choosing your preferred date and time, selecting services, and completing the payment process. The app will guide you through each step.",
    "How do I cancel my booking?":
        "To cancel a booking, go to \"My Bookings\" section, find the booking you want to cancel, and tap on the \"Cancel\" button. Cancellations made at least 2 hours before the scheduled time are eligible for a full refund.",
    "How do I earn reward coins?":
        "You can earn reward coins by booking car washes, referring friends, leaving reviews, and participating in special promotions. Visit the Rewards section to see all ways to earn coins.",
    "What if I'm not satisfied with the service?":
        "Your satisfaction is our priority. If you're not happy with the service, please contact our customer support within 24 hours of your appointment, and we'll make it right.",
    "Can I reschedule my booking?":
        "Yes, you can reschedule your booking through the \"My Bookings\" section. Select the booking you want to reschedule and tap the \"Reschedule\" button. Changes made at least 2 hours before the scheduled time are free of charge.",
  };

  final RxSet<String> expandedItems = <String>{}.obs;
  final TextEditingController userQuestionController = TextEditingController();

  void toggleItem(String key) {
    if (expandedItems.contains(key)) {
      expandedItems.remove(key);
    } else {
      expandedItems.add(key);
    }
  }

  void submitQuestion() {
    final question = userQuestionController.text.trim();
    if (question.isNotEmpty) {
      Get.snackbar("Submitted", "Your question has been submitted.");
      userQuestionController.clear();
    }
  }
}
