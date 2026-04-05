
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final bool? status;
  final int? unreadCount;
  final List<Notification>? notifications;

  NotificationModel({
    this.status,
  this.unreadCount,
    this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    unreadCount: json["unread_count"],
    notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "unread_count": unreadCount,
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  final int? id;
  final String? title;
  final String? body;
  final String? image;
  final String? route;
  final String? webLink;
  final dynamic sound;
  final dynamic arguments;
  final dynamic scheduledAt;
  final bool? sent;
  final bool? isRead;
  final String? timeHuman;

  Notification({
    this.id,
    this.title,
    this.body,
    this.image,
    this.route,
    this.webLink,
    this.sound,
    this.arguments,
    this.scheduledAt,
    this.sent,
    this.isRead,
    this.timeHuman,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    image: json["image"],
    route: json["route"],
    webLink: json["web_link"],
    sound: json["sound"],
    arguments: json["arguments"],
    scheduledAt: json["scheduled_at"],
    sent: json["sent"],
    isRead: json["is_read"],
    timeHuman: json["time_human"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "image": image,
    "route": route,
    "web_link": webLink,
    "sound": sound,
    "arguments": arguments,
    "scheduled_at": scheduledAt,
    "sent": sent,
    "is_read": isRead,
    "time_human": timeHuman,
  };
}
