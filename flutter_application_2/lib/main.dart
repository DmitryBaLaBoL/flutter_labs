import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа. Выполнил Тихонов Дмитрий ВМК-22'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
              children: [
                Container(color: Colors.red, width: 400, height: 400),
                Container(color: Colors.orange, width: 350, height: 350),
                Container(color: Colors.yellow, width: 300, height: 300),
                Container(color: Colors.green, width: 250, height: 250),
                Container(color: Colors.blue, width: 200, height: 200),
                Container(color: Colors.indigo, width: 150, height: 150),
                Container(color: Colors.purple, width: 100, height: 100),
              ],
          ),

        ],
      ),
    );
  }
}
