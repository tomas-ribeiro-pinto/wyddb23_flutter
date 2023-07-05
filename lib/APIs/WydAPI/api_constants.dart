import 'package:device_info/device_info.dart';
import 'dart:io';

class ApiConstants {

  static String baseUrl = "https://epinto.tech";
  static String apiUrl = baseUrl + "/api/";
  static String dev = getDevUrl() + "/api/";
  static String agenda = 'agenda';
  static String accommodation = 'accommodation';
  static String visit = 'visit';
  static String image = 'image';

  static String getDevUrl()
  {
    if (Platform.isAndroid)
    {
      // -- Android Localhost
      return 'http://10.0.2.2:8000';
    }
    
    return 'http://localhost:8000';
  }
}