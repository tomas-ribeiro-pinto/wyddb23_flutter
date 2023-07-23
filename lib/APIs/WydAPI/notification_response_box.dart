import 'package:hive/hive.dart';

import '../../Notifications/notification.dart';

part 'notification_response_box.g.dart';

@HiveType(typeId: 1)
class NotificationResponseBox extends HiveObject {
  @HiveField(0)
  late String endpoint;
 
  @HiveField(1)
  late String notifications;
 
  @HiveField(2)
  late int timestamp;
}