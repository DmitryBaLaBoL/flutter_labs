import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class CalculationsScreen extends StatefulWidget {
  const CalculationsScreen({super.key});

  @override
  State<CalculationsScreen> createState() => _CalculationsScreenState();
}

class _CalculationsScreenState extends State<CalculationsScreen> {
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  String _result = '';

  void _calculateComfort() {
    final temp = double.tryParse(_tempController.text);
    final humidity = double.tryParse(_humidityController.text);

    if (temp == null || humidity == null) {
      setState(() {
        _result = 'Введите корректные значения';
      });
      return;
    }

    String comfortLevel;
    String description;

    if (humidity < 30) {
      comfortLevel = 'Низкая влажность';
      description = 'Сухой воздух, рекомендуется увлажнитель';
    } else if (humidity < 60) {
      comfortLevel = 'Комфортная влажность';
      description = 'Идеальные условия';
    } else if (humidity < 80) {
      comfortLevel = 'Высокая влажность';
      description = 'Может ощущаться духота';
    } else {
      comfortLevel = 'Очень высокая влажность';
      description = 'Некомфортные условия, возможен конденсат';
    }

    final result = '$comfortLevel\n$description\nТемпература: $temp°C\nВлажность: $humidity%';

    setState(() {
      _result = result;
    });

    // Сохраняем в историю
    final calculation = CalculationHistory(
      type: 'Оценка комфортности влажности',
      input: 'Температура: $temp°C, Влажность: $humidity%',
      result: comfortLevel,
      timestamp: DateTime.now(),
    );

    StorageService.addCalculationToHistory(calculation);
  }

  void _clearHistory() {
    StorageService.clearCalculationsHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расчеты влажности'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Калькулятор
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Оценка комфортности влажности',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _tempController,
                      decoration: const InputDecoration(
                        labelText: 'Температура (°C)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _humidityController,
                      decoration: const InputDecoration(
                        labelText: 'Влажность (%)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _calculateComfort,
                      child: const Text('Рассчитать комфортность'),
                    ),
                    const SizedBox(height: 16),
                    if (_result.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(_result),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // История расчетов
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'История расчетов:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: _clearHistory,
                        child: const Text('Очистить'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<CalculationHistory>('calculations_history').listenable(),
                      builder: (context, box, _) {
                        final history = StorageService.getCalculationsHistory();
                        
                        if (history.isEmpty) {
                          return const Center(child: Text('История расчетов пуста'));
                        }

                        return ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final calculation = history[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: const Icon(Icons.calculate),
                                title: Text(calculation.type),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Вход: ${calculation.input}'),
                                    Text('Результат: ${calculation.result}'),
                                  ],
                                ),
                                trailing: Text(
                                  '${calculation.timestamp.hour}:${calculation.timestamp.minute}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
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
}