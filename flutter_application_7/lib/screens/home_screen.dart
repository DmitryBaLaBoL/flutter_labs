import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../cubit/weather_cubit.dart';
import '../models/weather_data.dart';
import '../services/storage_service.dart';
import 'developer_screen.dart';
import 'calculations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погодное приложение'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculationsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Поиск города
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Введите город',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      context.read<WeatherCubit>().loadWeather(_cityController.text);
                    }
                  },
                  child: const Text('Поиск'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Текущая погода
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherError) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.red[50],
                    child: Text(state.message),
                  );
                } else if (state is WeatherLoaded) {
                  return _buildWeatherCard(state.weatherData);
                } else {
                  return const Center(child: Text('Введите город для поиска погоды'));
                }
              },
            ),

            const SizedBox(height: 20),

            // История запросов
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'История запросов:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<WeatherData>('weather_history').listenable(),
                      builder: (context, box, _) {
                        final history = StorageService.getWeatherHistory();
                        
                        if (history.isEmpty) {
                          return const Center(child: Text('История запросов пуста'));
                        }

                        return ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final weather = history[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: const Icon(Icons.cloud),
                                title: Text(weather.city),
                                subtitle: Text('${weather.temperature}°C, ${weather.humidity}% влажности'),
                                trailing: Text(weather.comfortLevel),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherData weather) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.city,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${weather.temperature}°C',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text('Ощущается как: ${weather.description}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherInfo('Влажность', '${weather.humidity}%'),
                _buildWeatherInfo('Ветер', '${weather.windSpeed} м/с'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getComfortColor(weather.humidity),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Уровень комфорта: ${weather.comfortLevel}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(weather.comfortDescription),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Color _getComfortColor(double humidity) {
    if (humidity < 30) return Colors.orange[100]!;
    if (humidity < 60) return Colors.green[100]!;
    if (humidity < 80) return Colors.yellow[100]!;
    return Colors.red[100]!;
  }
}