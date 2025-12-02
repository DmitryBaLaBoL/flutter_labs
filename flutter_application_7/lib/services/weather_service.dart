import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  // Вариант 1: Open-Meteo API (не требует ключа)
  static Future<WeatherData> getWeatherFromOpenMeteo(String city) async {
    try {
      // Сначала получаем координаты города
      final geocodingUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=ru&format=json',
      );
      
      final geocodingResponse = await http.get(geocodingUrl);
      if (geocodingResponse.statusCode != 200) {
        throw Exception('Город не найден');
      }
      
      final geocodingData = json.decode(geocodingResponse.body);
      if (geocodingData['results'] == null || geocodingData['results'].isEmpty) {
        throw Exception('Город "$city" не найден');
      }
      
      final result = geocodingData['results'][0];
      final lat = result['latitude'];
      final lon = result['longitude'];
      final cityName = result['name'];
      
      // Затем получаем погоду по координатам
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&timezone=auto',
      );
      
      final weatherResponse = await http.get(weatherUrl);
      if (weatherResponse.statusCode != 200) {
        throw Exception('Ошибка получения погоды');
      }
      
      final weatherData = json.decode(weatherResponse.body)['current'];
      
      return WeatherData(
        city: cityName,
        temperature: weatherData['temperature_2m']?.toDouble() ?? 0.0,
        humidity: weatherData['relative_humidity_2m']?.toDouble() ?? 0.0,
        description: _getWeatherDescription(weatherData['weather_code'] ?? 0),
        windSpeed: weatherData['wind_speed_10m']?.toDouble() ?? 0.0,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      print('Open-Meteo error: $e');
      throw Exception('Не удалось получить данные. Проверьте название города.');
    }
  }

  // Вариант 2: WeatherAPI (если нужен ключ, но есть демо)
  static Future<WeatherData> getWeatherFromWeatherAPI(String city) async {
    try {
      // Демо-ключ (может иметь ограничения)
      const apiKey = 'your_key_here'; // Можно оставить пустым для тестирования
      final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&lang=ru');
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData(
          city: data['location']['name'],
          temperature: data['current']['temp_c']?.toDouble() ?? 0.0,
          humidity: data['current']['humidity']?.toDouble() ?? 0.0,
          description: data['current']['condition']['text'] ?? 'Неизвестно',
          windSpeed: data['current']['wind_kph']?.toDouble() ?? 0.0,
          timestamp: DateTime.now(),
        );
      } else {
        throw Exception('Город не найден или ошибка API');
      }
    } catch (e) {
      print('WeatherAPI error: $e');
      throw Exception('Ошибка получения данных');
    }
  }

  // Основной метод, который пробует разные API
  static Future<WeatherData> getWeather(String city) async {
    try {
      // Пробуем Open-Meteo сначала (не требует ключа)
      return await getWeatherFromOpenMeteo(city);
    } catch (e) {
      print('Open-Meteo failed: $e');
      
      // Если Open-Meteo не сработал, пробуем WeatherAPI
      try {
        return await getWeatherFromWeatherAPI(city);
      } catch (e2) {
        print('WeatherAPI also failed: $e2');
        throw Exception('Не удалось получить данные погоды. Проверьте подключение к интернету и название города.');
      }
    }
  }

  // Вспомогательный метод для преобразования кода погоды в текст
  static String _getWeatherDescription(int code) {
    const weatherCodes = {
      0: 'Ясно',
      1: 'Преимущественно ясно',
      2: 'Переменная облачность',
      3: 'Пасмурно',
      45: 'Туман',
      48: 'Туман с инеем',
      51: 'Лекая морось',
      53: 'Умеренная морось',
      55: 'Сильная морось',
      61: 'Небольшой дождь',
      63: 'Умеренный дождь',
      65: 'Сильный дождь',
      80: 'Ливень',
      95: 'Гроза',
    };
    
    return weatherCodes[code] ?? 'Неизвестно';
  }
}