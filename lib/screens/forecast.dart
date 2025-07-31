import 'package:flutter/material.dart';
import '../widgets/daily_forecast.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<Map<String, dynamic>> _forecastData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    try {
      // Replace with actual API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
      final now = DateTime.now();
      final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      
      setState(() {
        _forecastData = List.generate(5, (index) {
          final day = (now.weekday + index) % 7;
          return {
            'day': weekdays[day],
            'icon': index.isEven ? Icons.wb_sunny : Icons.cloud,
            'temp': '${22 + index}°C',
            'rain': '${index * 10}%',
          };
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('5-Day Forecast')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _forecastData.length,
              itemBuilder: (context, index) {
                final item = _forecastData[index];
                return DailyForecastItem(
                  day: item['day'],
                  icon: item['icon'],
                  temp: item['temp'],
                  rain: item['rain'],
                );
              },
            ),
    );
  }
}