class WeatherRespones {
  final temperature;
  final weather;
  final location;
  final cloud;
  final humidity;
  final windspeed;
  final description;

  WeatherRespones(
      {required this.temperature,
      required this.weather,
      required this.location,
      required this.description,
      required this.cloud,
      required this.humidity,
      required this.windspeed});
  factory WeatherRespones.fromJSON(Map<String, dynamic> json) {
    return WeatherRespones(
        temperature: json["main"]["temp"],
        weather: json["weather"][0]["main"],
        location: json["name"],
        humidity: json["main"]["humidity"],
        windspeed: json["wind"]["speed"],
        cloud: json["clouds"]["all"],
        description: json["weather"][0]["description"]);
  }
}
