import 'package:hive_flutter/hive_flutter.dart';
import '../models/weather_data.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const String _weatherBox = 'weather_history';
  static const String _calculationsBox = 'calculations_history';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Регистрируем адаптеры ПРАВИЛЬНО
    Hive.registerAdapter(WeatherDataAdapter());
    Hive.registerAdapter(CalculationHistoryAdapter());
    
    await Hive.openBox<WeatherData>(_weatherBox);
    await Hive.openBox<CalculationHistory>(_calculationsBox);
    
    print('Hive storage initialized successfully');
  }

  // Weather history
  static void addWeatherToHistory(WeatherData weather) {
    final box = Hive.box<WeatherData>(_weatherBox);
    final key = '${weather.city}_${weather.timestamp.millisecondsSinceEpoch}';
    box.put(key, weather);
  }

  static List<WeatherData> getWeatherHistory() {
    final box = Hive.box<WeatherData>(_weatherBox);
    return box.values.toList().reversed.toList();
  }

  // Calculations history
  static void addCalculationToHistory(CalculationHistory calculation) {
    final box = Hive.box<CalculationHistory>(_calculationsBox);
    final key = '${calculation.type}_${calculation.timestamp.millisecondsSinceEpoch}';
    box.put(key, calculation);
  }

  static List<CalculationHistory> getCalculationsHistory() {
    final box = Hive.box<CalculationHistory>(_calculationsBox);
    return box.values.toList().reversed.toList();
  }

  static void clearWeatherHistory() {
    final box = Hive.box<WeatherData>(_weatherBox);
    box.clear();
  }

  static void clearCalculationsHistory() {
    final box = Hive.box<CalculationHistory>(_calculationsBox);
    box.clear();
  }
}