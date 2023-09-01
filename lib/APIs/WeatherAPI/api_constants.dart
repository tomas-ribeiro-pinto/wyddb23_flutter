import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = 'https://api.weatherapi.com/v1/';
  static String currentWeather = 'current.json?key=${dotenv.env['WEATHER_API_KEY']}&q=Lisboa&aqi=no';
}