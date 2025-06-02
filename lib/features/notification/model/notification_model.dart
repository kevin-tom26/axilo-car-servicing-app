class NotificationModel {
  String notificationIcon;
  String notificationTitle;
  String notificationContent;
  DateTime timestamp;
  bool isMessageRead;

  NotificationModel({
    required this.notificationIcon,
    required this.notificationTitle,
    required this.notificationContent,
    required this.timestamp,
    required this.isMessageRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notificationIcon: json["notification_icon"],
        notificationTitle: json["notification_title"],
        notificationContent: json["notification_content"],
        timestamp: DateTime.parse(json["timestamp"]),
        isMessageRead: json["isMessageRead"],
      );

  Map<String, dynamic> toJson() => {
        "notification_icon": notificationIcon,
        "notification_title": notificationTitle,
        "notification_content": notificationContent,
        "timestamp": timestamp.toIso8601String(),
        "isMessageRead": isMessageRead,
      };
}
