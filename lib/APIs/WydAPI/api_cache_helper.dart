import 'dart:async';
import 'dart:convert';
 
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/accommodation_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/image_model.dart';

import '../WeatherAPI/api_service.dart';
import 'Models/visit_model.dart';
import 'api_response_box.dart';
import 'Models/agenda_model.dart';

import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';
 
class ApiCacheHelper {
  static const int _cacheTimeout = 60 * 60 * 1000 * 2; // 2 hours
 
  static Future<List<Day>> getAgenda() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('agenda');

/*     if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return dayFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    } */
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getAgenda();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'agenda'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('agenda', newResponse);
 
    return dayFromJson(response as String);
  }

  static Future<List<Visit>> getVisit() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('visit');

    if (cachedResponse != null) {
      // Expires after 1 day
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 12 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return visitFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getVisit();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'visit'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('visit', newResponse);
 
    return visitFromJson(response as String);
  }

  static Future<List<Accommodation>> getAccommodation(String location) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get(location + '.accommodation');

    if (cachedResponse != null) {
      // Expires after 1 day
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 24 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return accommodationFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getAccommodation(location);

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = location + '.accommodation'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put(location + '.accommodation', newResponse);
 
    return accommodationFromJson(response as String);
  }

  static Future<Weather> getWeather() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('weather');

    if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout / 2 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return weatherFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WeatherApiService().getWeather();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'weather'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('weather', newResponse);
 
    return weatherFromJson(response as String);
  }

  static Future<String> getHomePic() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('image');

    if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < (_cacheTimeout / 8) || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return imageFromJson(json.decode(cachedResponse.response))[0].imageUrl;
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getHomePic();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'image'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('image', newResponse);
 
    return imageFromJson(response as String)[0].imageUrl;
  }
}