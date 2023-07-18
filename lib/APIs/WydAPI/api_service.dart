import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/story_model.dart';
import 'api_constants.dart';
import 'Models/agenda_model.dart';

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

  Future<String?> getAccommodation(String location) async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.accommodation + '/' + location);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getFaq() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.faq);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getContacts() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.contact);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getInformation() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.information);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getGuides() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.guide);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getFatimaGuides() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.fatimaGuide);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getFatimaVisits() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.fatimaVisit);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getTimetable() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.timetable);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getMap() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.map);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Story>?> getStories() async {
    try {
      var url = Uri.parse(ApiConstants.apiUrl + ApiConstants.story);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return storyFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}