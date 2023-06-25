import 'package:device_info/device_info.dart';
import 'dart:io';

class ApiConstants {

  static String baseUrl = getUrl();
  static String timetables = 'timetables';

  static String getUrl()
  {
    if (Platform.isAndroid)
    {
      // -- Android Localhost
      return 'http://10.0.2.2:8000/api/';
    }
    
    return 'http://localhost:8000/api/';
  }
}