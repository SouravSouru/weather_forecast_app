import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_responses.dart';

String? cityName;

Future<WeatherRespones> getWeather() async {
  const apiKey = "your openWeather Api Key";
  final response = await http.get(
    Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey"),
  );
  if (response.statusCode == 200) {
    final _jsondata = jsonDecode(response.body) as Map<String, dynamic>;
    final weatherData = WeatherRespones.fromJSON(_jsondata);
    return weatherData;
  } else {
    throw Exception("Failed To Load");
  }
}
