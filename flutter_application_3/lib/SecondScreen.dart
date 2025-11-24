import 'package:flutter/material.dart';
import 'dart:math';


class SecondScreen extends StatelessWidget {
  final String numA;
  final String numB;

  const SecondScreen({super.key, required this.numA, required this.numB});

  @override
  Widget build(BuildContext context) {
    num sum = (int.parse(numA) * pow(int.parse(numB),2)) / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center, //Центрирование
        children: <Widget>[ 
          Padding(padding: EdgeInsets.all(16.0), child:  Text(
          'Результат ($numA + $numB^2) / 2 = $sum Дж.',
          style: const TextStyle(fontSize: 24),
        )),
          const SizedBox(height: 20.0),
         ElevatedButton(onPressed: (){
           Navigator.pop(context);
         },
         child: Text('Переход к калькулятору'),
      )],
        
      ),
    );
  }
}