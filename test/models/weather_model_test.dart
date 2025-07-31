import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  group('Weather Model', () {
    test('fromJson returns a valid Weather object', () {
      final json = {
        "name": "Freetown",
        "main": {"temp": 28.5, "humidity": 70},
        "weather": [
          {"main": "Clear", "description": "sunny"}
        ],
        "wind": {"speed": 12.0}
      };

      final weather = Weather.fromJson(json);

      expect(weather.cityName, "Freetown");
      expect(weather.temperature, 28.5);
      expect(weather.condition, "Clear");
      expect(weather.description, "sunny");
      expect(weather.humidity, 70);
      expect(weather.windSpeed, 12.0);
      expect(weather.getWeatherIcon(), contains("sun.png")); // icon check
    });
  });
}
