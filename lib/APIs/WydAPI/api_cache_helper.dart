import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:wyddb23_flutter/APIs/WydAPI/Models/emergency_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/new_guide_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/prayer_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/streaming_link_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/sym_map_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/timetable_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_constants.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/accommodation_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/contact_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/faq_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/image_model.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';

import '../WeatherAPI/api_service.dart';
import 'Models/guide_model.dart';
import 'Models/information_model.dart';
import 'Models/visit_model.dart';
import 'api_response_box.dart';
import 'Models/agenda_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/agenda_model.dart' as agenda;

import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';
 
class ApiCacheHelper {
  static const int _cacheTimeout = 60 * 60 * 1000 * 2; // 2 hours
 
  static Future<List<agenda.Day>> getAgenda() async {
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
      ..endpoint = 'agenda'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('agenda', newResponse);
 
    return dayFromJson(response as String);
  }

  static Future<List<List<Prayer>>> getPrayers() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('prayers');

    if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return prayerFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getPrayer();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'prayers'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('prayers', newResponse);
 
    return prayerFromJson(response as String);
  }


  static Future<List<Visit>> getVisits() async {
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

  static Future<List<Visit>> getFatimaVisits() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('fatimaVisit');

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
    final response = await WydApiService().getFatimaVisits();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'fatimaVisit'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('fatimaVisit', newResponse);
 
    return visitFromJson(response as String);
  }

  static Future<List<Accommodation>> getAccommodation(String location) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get(location + '.accommodation');

    if (cachedResponse != null) {
      // Expires after 12 hours
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 6 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return accommodationFromJson(json.decode(cachedResponse.response))[0];
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
 
    return accommodationFromJson(response as String)[0];
  }

  static Future<List<Faq>> getFaq() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('faq');

    if (cachedResponse != null) {
      // Expires after 2 days
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 24 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return faqFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getFaq();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'faq'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('faq', newResponse);
 
    return faqFromJson(response as String);
  }

  static Future<List<Contact>> getContacts() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('contact');

    if (cachedResponse != null) {
      // Expires after 2 days
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 24 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return contactFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getContacts();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'contact'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('contact', newResponse);
 
  return contactFromJson(response as String);
  }

  static Future<Map<String, Guide>?> getOldGuides() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiGuides');

    List<Guide> guides = await saveGuides();

    Map<String, Guide> guidePaths = new Map();

    for(Guide guide in guides)
    {
      var asset = box.get(guide.assetUrl);

      if(asset != null)
      {
        if(asset.timestamp != guide.createdAt.millisecondsSinceEpoch)
        {
          guidePaths.addAll(await fetchPdf(guide, box));
        }

        guidePaths[asset.endpoint] = Guide.fromJson(json.decode(asset.response));
      }
      else
      {
          guidePaths.addAll(await fetchPdf(guide, box));
      }
    }

    return guidePaths;
  }

  static Future<List<List<NewGuide>>> getGuides() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('guides');

    if (cachedResponse != null) {
      // Expires after 1 hours
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout / 2 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return newGuideFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getGuides();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'guides'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('guides', newResponse);
 
    return newGuideFromJson(response as String);
  }

  static Future<List<List<NewGuide>>> getFatimaGuides() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('fatimaGuides');

    if (cachedResponse != null) {
      // Expires after 1 hours
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout / 2 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return newGuideFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getFatimaGuides();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'fatimaGuides'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('fatimaGuides', newResponse);
 
    return newGuideFromJson(response as String);
  }

  static Future<Map<String, Timetable>> getTimetable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('timetable');

    if (cachedResponse != null) {
      // Expires after 1 hour
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout / 2 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return timetableFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getTimetable();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'timetable'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('timetable', newResponse);
 
    return timetableFromJson(response as String);
  }

  static Future<String?> getLiveStreaming() async {
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getLiveStreaming();
 
    return streamingLinkFromJson(response as String).url;
  }

  static Future<List<List<Information>>> getInformation() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('information');

    if (cachedResponse != null) {
      // Expires after 6 hours
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 3 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return informationFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getInformation();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'information'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('information', newResponse);
 
    return informationFromJson(response as String);
  }

  static Future<Emergency?> getEmergency() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('emergency');

/*     if (cachedResponse != null) {
      // Expires after 6 hours
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 3 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return emergencyFromJson(json.decode(cachedResponse.response))[0][0];
      else
      {
        box.delete(cachedResponse.key);
      }
    } */
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getEmergency();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'emergency'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('emergency', newResponse);
 
    return emergencyFromJson(response as String)[0][0];
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

  static Future<Map<String, Guide>> fetchPdf(Guide guide, var box) async
  {
    Map<String, Guide> map = new Map();
    File file = await WydResources.loadPdfUrl(ApiConstants.storage + guide.assetUrl);

    final newResponse = ApiResponseBox()
      ..endpoint = file.path
      ..response = json.encode(guide)
      ..timestamp = guide.createdAt.millisecondsSinceEpoch;
    await box.put(guide.assetUrl, newResponse);

    map[newResponse.endpoint] = Guide.fromJson(json.decode(newResponse.response));

    return map;
  }

  static Future<String>? getMap(String currentLanguageCode) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');

    final cachedResponse = box.get('mapFile_$currentLanguageCode');

    SymMap map = await saveMap(currentLanguageCode);

    String url = "";

    if(cachedResponse != null)
    {
        if(cachedResponse.timestamp != map.updatedAt && cachedResponse.response.substring(cachedResponse.response.lastIndexOf("/") + 1) != 'null') {
          return cachedResponse.response;
        } else
        {
          url = await fetchMapPdf(map, box, currentLanguageCode);
        }
    }
    else
    {
      url = await fetchMapPdf(map, box, currentLanguageCode);
    }

    return url;
  }

  static Future<SymMap> saveMap(String currentLanguageCode) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('map_$currentLanguageCode');

    if (cachedResponse != null) {
      if(DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp < _cacheTimeout * 1.5 || connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return symMapFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getMap();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'map_$currentLanguageCode'
      ..response = json.encode(response)
      ..timestamp = symMapFromJson(response as String).updatedAt.millisecondsSinceEpoch;
    await box.put('map_$currentLanguageCode', newResponse);
 
  return symMapFromJson(response as String);
  }

  static Future<String> fetchMapPdf(SymMap symMap, var box, String currentLanguageCode) async
  {
    File file = await WydResources.loadPdfUrl(ApiConstants.storage + symMap.getTranslatedMap(currentLanguageCode));

    final newResponse = ApiResponseBox()
      ..endpoint =  'mapFile_$currentLanguageCode'
      ..response = file.path
      ..timestamp = symMap.updatedAt.millisecondsSinceEpoch;
    await box.put('mapFile_$currentLanguageCode', newResponse);

    return file.path;
  }

  static Future<List<Guide>> saveGuides() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');
    final cachedResponse = box.get('guides');

    if (cachedResponse != null) {
      if(connectivityResult == ConnectivityResult.none)
        // Return cached response if it's not expired yet
        return guideFromJson(json.decode(cachedResponse.response));
      else
      {
        box.delete(cachedResponse.key);
      }
    }
 
    // Fetch new response if cache is expired or not available
    final response = await WydApiService().getGuides();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint =  'guides'
      ..response = json.encode(response)
      ..timestamp = DateTime.now().millisecondsSinceEpoch;
    await box.put('guides', newResponse);
 
  return guideFromJson(response as String);
  }
}