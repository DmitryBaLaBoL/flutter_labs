import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit_provider.dart';

class SecondScreen extends StatelessWidget {
  final int numA;
  final int numB;
  final num result;

  const SecondScreen({super.key, required this.numA, required this.numB, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Кинетическая энергия тела массой $numA кг и скоростью $numB м/с = $result Дж', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<NavigationCubit>().showFirstScreen();
              },
              child: const Text('Переход к калькулятору'),
            ),
          ],
        ),
      ),
    );
  }
}