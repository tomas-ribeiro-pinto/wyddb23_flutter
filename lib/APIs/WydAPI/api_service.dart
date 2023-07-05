import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'api_constants.dart';
import 'day_model.dart';

class WydApiService {
  Future<String?> getAgenda() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.agenda);
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
      var url = Uri.parse(ApiConstants.dev + ApiConstants.image);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}