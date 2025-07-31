import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();

  final String apiKey = '49a907d0100f19add35adb638e511ae3'; // 🔑 Replace this

  Future<Weather> fetchWeather(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    try {
      final response = await _dio.get(url);
      return Weather.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
