import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:io';

import 'package:weatherappg14/models/weather_model.dart';

class ApiService {
  Logger logger = Logger();

  String urlBase = "http://api.weatherapi.com/v1";

  Future<void> getWeatherInfo() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=lima&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        logger.i("""Weather api response 
    $response
    ${response.statusCode}
    ${response.body} 
        """);
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  Future<void> getWeatherInfoByName() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=lima&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        logger.i("""Weather api response 
    $response
    ${response.statusCode}
    ${response.body} 
        """);
        final data = json.decode(response.body);
        logger.f(data);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        logger.w(weatherModel.location.name);
      }
    } catch (e) {
      throw Exception("Error inesperado - $e");
    }
  }
}
