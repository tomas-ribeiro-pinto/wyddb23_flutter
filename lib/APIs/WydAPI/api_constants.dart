import 'package:device_info/device_info.dart';
import 'dart:io';

class ApiConstants {

  static String baseUrl = "https://epinto.tech";
  static String storage = "https://epinto.tech/storage/";
  static String apiUrl = baseUrl + "/api/";
  static String dev = getDevUrl() + "/api/";
  static String devStorage = getDevUrl() + "/storage/";
  static String agenda = 'agenda';
  static String accommodation = 'accommodation';
  static String visit = 'visit';
  static String image = 'image';
  static String contact = 'contact';
  static String information = 'information';
  static String faq = 'faq';
  static String guide = 'guide';
  static String story = 'story';
  static String map = 'map';
  static String timetable = 'timetable';
  static String fatimaGuide = 'fatima/guide';
  static String fatimaVisit = 'fatima/visit';
  static String emergency = 'emergency';
  static String symForum = 'sym-forum';
  static String liveStreaming = 'live-streaming';
  static String prayer = 'prayer';
  static String cache = 'cache';

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