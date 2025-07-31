import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${weather.temperature}°C',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 8),
            Text(
              weather.condition,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop),
                    Text('${weather.humidity}%'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.air),
                    Text('${weather.windSpeed} km/h'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}