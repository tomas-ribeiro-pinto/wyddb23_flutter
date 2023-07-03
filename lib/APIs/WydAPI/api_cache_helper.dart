import 'dart:convert';
 
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';

import '../WeatherAPI/api_service.dart';
import 'api_response_box.dart';
import 'day_model.dart';

import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';
 
class ApiCacheHelper {
  static const int _cacheTimeout = 60 * 60 * 1000 * 2; // 2 hours
 
  static Future<List<Day>> getAgenda(String endpoint) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('agenda');

    if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return dayFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getAgenda();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = endpoint
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('agenda', newResponse);
 
    return dayFromJson(response as String);
  }

  static Future<Weather> getWeather(String endpoint) async {
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
      ..endpoint = endpoint
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('weather', newResponse);
 
    return weatherFromJson(response as String);
  }
}