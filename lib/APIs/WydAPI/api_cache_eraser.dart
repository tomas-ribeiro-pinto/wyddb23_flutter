
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';

import 'Models/cache_eraser_model.dart';
import 'api_response_box.dart';

class ApiCacheEraser {
  static const int _cacheTimeout = 60 * 60 * 1000 * 2; // 2 hours
 
  static Future<CacheEraser> getCacheEraserInfo() async {
    final response = await WydApiService().getCache();

    return cacheEraserFromJson(response as String).first;
  }

  static Future<void> checkCacheEraserInfo(CacheEraser eraser) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    var box = await Hive.openBox<ApiResponseBox>('cacheEraser');
    final cachedResponse = box.get('cacheEraser');

    if(connectivityResult != ConnectivityResult.none)
    {
      if (cachedResponse != null) {
        if(cachedResponse.timestamp != eraser.updatedAt.millisecondsSinceEpoch)
        {
          eraseCache();
        }
      }
      else
      {
          eraseCache();
      }
    }
  }

  static void eraseCache() async
  {
    var box = await Hive.openBox<ApiResponseBox>('cacheEraser');
    var apiBox = await Hive.openBox<ApiResponseBox>('apiResponses');

    apiBox.deleteAll(apiBox.keys);

    final response = await WydApiService().getCache();

    // Save new response to cache
    final newResponse = ApiResponseBox()
      ..endpoint = 'cacheEraser'
      ..response = json.encode(response)
      ..timestamp = cacheEraserFromJson(response as String)[0].updatedAt.millisecondsSinceEpoch;
    await box.put('cacheEraser', newResponse);
  }
}