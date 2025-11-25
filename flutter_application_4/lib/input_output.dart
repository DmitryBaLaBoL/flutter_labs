import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'qubit.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  InputScreenState createState() => InputScreenState();
}

class InputScreenState extends State<InputScreen> {
  final formKey = GlobalKey<FormState>();
  final massController = TextEditingController();
  final speedController = TextEditingController();
  bool agreeToProcessData = false;
  final Qubit qubit = Qubit();

  @override
  void dispose() {
    massController.dispose();
    speedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Лабораторная работа №4 Тихонов Д.С. ВМК-22 вар(4)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: massController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Масса (кг)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите массу';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Пожалуйста, введите корректное число';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Масса должна быть больше нуля';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: speedController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Скорость (м/с)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите скорость';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Пожалуйста введите корректное число';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Скорость должна быть больше 0';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: agreeToProcessData,
                    onChanged: (value) {
                      setState(() {
                        agreeToProcessData = value!;
                      });
                    },
                  ),
                  const Text('Соглашаюсь на обработку данных'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() && agreeToProcessData) {
                    final double mass = double.parse(massController.text);
                    final double radius = double.parse(speedController.text);

                    final QubitState state = QubitState(mass: mass, radius: radius);

                    final double acceleration = qubit.calculateAcceleration(state.mass, state.radius);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Кинетическая энергия'),
                          content: Text(
                            'Кинетическая энергия: ${acceleration} Дж',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Закрыть'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    if (!agreeToProcessData) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Пожалуйста, подтвердите согласие на обработку данных')),
                      );
                    }
                  }
                },
                child: const Text('Вычислить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}