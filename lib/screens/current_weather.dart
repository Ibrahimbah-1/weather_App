import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:dio/dio.dart';


class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  late Future<Weather> _weatherFuture;
  final WeatherService _weatherService = WeatherService(dio: Dio());

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final weather = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade300,
                ],
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  title: const Text('Weather App'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${weather.temperature.round()}°C',
                        style: const TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        weather.condition,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildWeatherInfo(Icons.water_drop, '${weather.humidity}%', 'Humidity'),
                            _buildWeatherInfo(Icons.air, '${weather.windSpeed} km/h', 'Wind'),
                            _buildWeatherInfo(Icons.visibility, '10 km', 'Visibility'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}