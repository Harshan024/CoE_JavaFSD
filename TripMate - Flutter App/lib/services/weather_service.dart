import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  static const String _baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    try {
      final Uri url = Uri.parse("$_baseUrl?key=$_apiKey&q=$city&aqi=no");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error fetching weather: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Failed to fetch weather: $e");
      return null;
    }
  }
}
