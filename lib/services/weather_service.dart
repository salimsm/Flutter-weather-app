import 'package:flutter_weather_app/models/wheather_model.dart';
import 'package:http/http.dart' as http;

const String ApiKey = "20aecb09e66fbb53a6c707b4ebd836e3";

class WeatherService {

  static Future getWeatherDetails(String cityName) async {
    final queryParameter = {
      'q': cityName,
      'appid': '20aecb09e66fbb53a6c707b4ebd836e3',
      'units': 'metric'
    };
    var url = Uri.https(
        "api.openweathermap.org", "/data/2.5/weather", queryParameter);
    WeatherModel weatherModel;
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        weatherModel = weatherModelFromJson(response.body);
        return weatherModel;
      }
      return false;
    } catch (e) {
      print(e.toString());
    }
  }
}