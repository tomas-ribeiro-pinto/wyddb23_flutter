import 'package:hive/hive.dart';

part 'api_response_box.g.dart';

@HiveType(typeId: 0)
class ApiResponseBox extends HiveObject {
  @HiveField(0)
  late String endpoint;
 
  @HiveField(1)
  late String response;
 
  @HiveField(2)
  late int timestamp;
}