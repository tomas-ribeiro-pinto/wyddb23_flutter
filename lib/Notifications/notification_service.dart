import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:timezone/timezone.dart';
import 'package:wyddb23_flutter/Notifications/notification.dart' as noti;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:wyddb23_flutter/Notifications/notification.dart' as notification;

import '../APIs/WydAPI/api_response_box.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('bw_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            color: WydColors.red,
            'channelId', 'channelName',
            importance: Importance.max,
            styleInformation: BigTextStyleInformation('')),
        iOS: const DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    
    noti.Notification.saveNotification(notification.Notification(title, body, null, DateTime.now()));

    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
    {int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleNotificationDateTime}) async
    {
      return notificationsPlugin.zonedSchedule(
        id, 
        title, 
        body, 
        TZDateTime.from(
          scheduleNotificationDateTime,
          getLocation('Europe/Lisbon')
        ), 
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
    }

  static void saveAlarm(int id) async { 
    var box = await Hive.openBox<ApiResponseBox>('notifications');
    final cachedResponse = box.get('scheduled');

    List<dynamic> timetableEntrys = [];

    if(cachedResponse != null)
    {
      timetableEntrys = jsonDecode(cachedResponse.response);
    }

    timetableEntrys.add(id);

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'map'
      ..response = json.encode(timetableEntrys)
      ..timestamp = DateTime.now().microsecondsSinceEpoch;
    await box.put('scheduled', newResponse);
  }

  static Future<List<dynamic>?> getAlarms() async { 
    var box = await Hive.openBox<ApiResponseBox>('notifications');
    final cachedResponse = box.get('scheduled');

    List<dynamic> alarms = [];

    if(cachedResponse != null)
      return alarms = jsonDecode(cachedResponse!.response);

    return alarms;
  }

  static void setWelcome(BuildContext context) async { 
    NotificationService().scheduleNotification(
      title: translation(context).wNotificationTitle,
      body: translation(context).wNotificationBody,
      scheduleNotificationDateTime: DateTime.now().add(Duration(minutes: 5))
    );
  }

}