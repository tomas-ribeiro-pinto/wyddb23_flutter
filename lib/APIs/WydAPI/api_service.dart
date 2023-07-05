import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'api_constants.dart';
import 'Models/day_model.dart';

class WydApiService {
  Future<String?> getAgenda() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.agenda);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getHomePic() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.image);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  
  Future<String?> getVisit() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.visit);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}