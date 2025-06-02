// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    log('date - ${DateTime.now()}');
    getAllNotification();
    super.onInit();
  }

  final RxList<NotificationModel> allNotifications = <NotificationModel>[].obs;

  void getAllNotification() {
    LocalData().dummyNotificationForTesting.forEach((notification) {
      allNotifications.add(NotificationModel.fromJson(notification));
    });
  }

  Map<String, List<NotificationModel>> get groupedNotifications {
    final now = DateTime.now();
    Map<String, List<NotificationModel>> grouped = {};

    for (var notif in allNotifications) {
      final ts = notif.timestamp;
      String key;

      if (DateUtils.isSameDay(ts, now)) {
        key = 'Today';
      } else if (DateUtils.isSameDay(ts, now.subtract(const Duration(days: 1)))) {
        key = 'Yesterday';
      } else {
        key = DateFormat('dd-MM-yyyy').format(ts);
      }

      grouped.putIfAbsent(key, () => []).add(notif);
    }

    return grouped;
  }

  void markAllAsRead(String group) {
    final notifs = groupedNotifications[group];
    if (notifs != null) {
      for (var n in notifs) {
        n.isMessageRead = true;
      }
      allNotifications.refresh();
    }
  }

  String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inDays > 1) return '${diff.inDays}d';
    if (diff.inDays == 1) return '1d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return 'now';
  }
}
