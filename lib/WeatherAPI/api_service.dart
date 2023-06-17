import 'dart:developer';

import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'weather_model.dart';

class ApiService {
  Future<Weather?> getWeather() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.currentWeather);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Weather _model = weatherFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}