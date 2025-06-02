import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/notification/controller/notification_controller.dart';
import 'package:axilo/features/notification/model/notification_model.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: "Notification"),
      body: BottomSafeArea(
        child: Obx(() {
          final groups = notificationController.groupedNotifications;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 10),
            children: groups.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///  Group Header
                  Row(
                    children: [
                      Expanded(
                          child: Text(entry.key,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19, color: WColors.darkerGrey))),
                      TextButton(
                        onPressed: () => notificationController.markAllAsRead(entry.key),
                        child: Text("Mark all as read",
                            style: TextStyle(fontSize: 14, color: WColors.onPrimary, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  //   const SizedBox(height: 8),

                  ///  Notification Tiles
                  ...entry.value.map((notif) => _buildNotificationTile(notif)),

                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        }),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notif) {
    final DateTime ts = notif.timestamp;
    final String timeAgo = notificationController.getTimeAgo(ts);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        color: notif.isMessageRead ? Colors.grey[100] : Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF1F4FF),
              image: DecorationImage(
                  image: AssetImage(notif.notificationIcon),
                  scale: 2.8,
                  colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn))),
        ),
        visualDensity: VisualDensity(horizontal: -2),
        title: Text(
          notif.notificationTitle,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            notif.notificationContent,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[700], fontSize: 13.5),
          ),
        ),
        trailing: Text(timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }
}
