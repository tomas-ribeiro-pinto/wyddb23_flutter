import 'dart:developer';

import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'weather_model.dart';

class WeatherApiService {
  Future<String?> getWeather() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.currentWeather);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}