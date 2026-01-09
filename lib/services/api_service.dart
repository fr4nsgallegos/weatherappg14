import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  Logger logger = Logger();

  String urlBase = "http://api.weatherapi.com/v1";

  Future<void> getWeatherInfo() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=lima&aqi=no",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      logger.i("""Weather api response 
    $response
    ${response.statusCode}
    ${response.body} 
        """);
    } else {
      throw Exception("Error al cargar: ${response.statusCode}");
    }
  }
}
