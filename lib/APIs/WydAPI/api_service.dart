import 'dart:developer';

import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'day_model.dart';

class WydApiService {
  Future<List<Day>?> getTimetable() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.timetables);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Day> _model = dayFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}