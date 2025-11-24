import 'SecondScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Импорт для inputFormatters

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа №3 Тихонов Д.С. ВМК-22 вар(4)'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

@override
_MyFormState createState() => _MyFormState();
}


class _MyFormState extends State<MyHomePage> {
final _formKey = GlobalKey<FormState>();
final _fieldA = TextEditingController();
final _fieldB = TextEditingController();
bool _agreement = false;


@override
Widget build(BuildContext  context){
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey,
      child: Column(
      children: <Widget>[
        const Text('Введите массу тела: (кг)', style: TextStyle(fontSize: 16.0,)),
        TextFormField( controller: _fieldA, //Ввод числа a
         inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, //Осуществляем работу только через числа, чтобы пользователь не смог ввести буквы
              ],
          validator: (value) {
          if (value!.isEmpty) return 'Пожалуйста введите число!';
          return null; },
          keyboardType: TextInputType.number
          ),
          const SizedBox(height: 20.0), //Отступ между двумя вводимыми числами
          ////// Начинается ввод числа b
           const Text('Введите число скорость: (м/с)', style: TextStyle(fontSize: 16.0,)),
        TextFormField( controller: _fieldB,
         inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, //Осуществляем работу только через числа, чтобы пользователь не смог ввести буквы
              ],
          validator: (value) {
          if (value!.isEmpty) return 'Пожалуйста введите число!';
          return null; },
          keyboardType: TextInputType.number
          ),
      const SizedBox(height: 20.0),
      CheckboxListTile(value: _agreement, title: Text('Согласны ли вы на использование калькулятора кинетической энергии, введённые Вами данные будут использованы далее?', style: TextStyle(fontSize: 10.0),)
      ,onChanged: (bool? value) => setState(() =>  _agreement = value!)),
      const SizedBox(height: 20.0),
      ElevatedButton(onPressed: () {
        if (_formKey.currentState!.validate())  {
          if (_agreement){
            int numA = int.parse(_fieldA.text);
            int numB = int.parse(_fieldB.text);
          Navigator.push(
            context,
           MaterialPageRoute(builder: (context) => SecondScreen(numA: _fieldA.text, numB: _fieldB.text)));
          }
          else {
            print('Вы не согласились с условиями!');
          }
        }


      }, child: const Text('Передача параметров') )
      ],
    )),
  );
}
}