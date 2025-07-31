class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final DateTime? date;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? json['city']?['name'] ?? 'Unknown',
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      condition: json['weather']?[0]?['main'] ?? 'Unknown',
      description: json['weather']?[0]?['description'] ?? '',
      humidity: json['main']?['humidity']?.toInt() ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      date: json['dt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
          : null,
    );
  }

  String getDayOfWeek() {
    if (date == null) return '';
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date!.weekday % 7];
  }
}