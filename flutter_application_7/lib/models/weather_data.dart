import 'package:hive/hive.dart';

part 'weather_data.g.dart';

@HiveType(typeId: 0)
class WeatherData {
  @HiveField(0)
  final String city;
  
  @HiveField(1)
  final double temperature;
  
  @HiveField(2)
  final double humidity;
  
  @HiveField(3)
  final String description;
  
  @HiveField(4)
  final double windSpeed;
  
  @HiveField(5)
  final DateTime timestamp;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.windSpeed,
    required this.timestamp,
  });

  // Для API response
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      humidity: (json['main']['humidity'] ?? 0).toDouble(),
      description: json['weather'][0]['description'] ?? 'Unknown',
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      timestamp: DateTime.now(),
    );
  }

  String get comfortLevel {
    if (humidity < 30) return 'Низкая';
    if (humidity < 60) return 'Комфортная';
    if (humidity < 80) return 'Высокая';
    return 'Очень высокая';
  }

  String get comfortDescription {
    if (humidity < 30) return 'Сухой воздух, может вызывать сухость кожи';
    if (humidity < 60) return 'Идеальные условия для комфорта';
    if (humidity < 80) return 'Влажно, может быть душно';
    return 'Очень влажно, некомфортные условия';
  }
}