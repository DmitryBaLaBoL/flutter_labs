import 'package:flutter/material.dart';
import 'input_output.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор кинетической энергии',
      home: const InputScreen(),
    );
  }
}