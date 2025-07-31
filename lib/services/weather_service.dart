import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio dio;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '49a907d0100f19add35adb638e511ae3'; // Your API key

  WeatherService({required this.dio});

  Future<Weather> getCurrentWeather() async {
    try {
      final position = await _getCurrentPosition();
      final response = await dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': position.latitude,
          'lon': position.longitude,
          'appid': _apiKey,
          'units': 'metric',
        },
      );
      return Weather.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  Future<List<Weather>> getForecast() async {
    try {
      final position = await _getCurrentPosition();
      final response = await dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'lat': position.latitude,
          'lon': position.longitude,
          'appid': _apiKey,
          'units': 'metric',
          'cnt': 5, // 5 days forecast
        },
      );
      return (response.data['list'] as List)
          .map((item) => Weather.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<Position> _getCurrentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled');
    }
    
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
    
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}