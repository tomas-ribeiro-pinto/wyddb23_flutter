import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/notification_response_box.dart';

import 'package:wyddb23_flutter/Notifications/notification.dart' as noti;

class Notification{
  Notification(this.title, this.body, this.payLoad, this.receivedAt);

  String? title;
  String? body;
  Map<String, dynamic>? payLoad;
  DateTime? receivedAt;

  static List<Notification> notificationsFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));
  static String notificationsToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    payLoad = json['payLoad'];
    receivedAt = DateTime.parse(json['receivedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['payLoad'] = this.payLoad;
    data['receivedAt'] = this.receivedAt?.toIso8601String();
    return data;
 }
  
  static Future<void> saveNotification(noti.Notification notification)
  async {
    var box = await Hive.openBox<NotificationResponseBox>('Notifications');
    final cachedResponse = box.get('notifications');

    List<noti.Notification> notifications = [];

    if(cachedResponse != null)
    {
      notifications = notificationsFromJson(cachedResponse.notifications);
    }

    notifications.add(notification);

    // Save new response to cache
    final newResponse = NotificationResponseBox()
      ..endpoint =  'notifications'
      ..notifications = notificationsToJson(notifications)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('notifications', newResponse);
  }

  static Future<List<Notification>> getNotifications()
  async {
    var box = await Hive.openBox<NotificationResponseBox>('Notifications');
    final cachedResponse = box.get('notifications');

    List<noti.Notification> notifications = [];

    if(cachedResponse != null)
    {
      return notificationsFromJson(cachedResponse.notifications);
    }

    return notifications;

  }

  static void clearNotifications() async
  {
    var box = await Hive.openBox<NotificationResponseBox>('Notifications');
    box.delete('notifications');
  }
}